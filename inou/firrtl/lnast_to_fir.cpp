//  This file is distributed under the BSD 3-Clause License. See LICENSE for details.

#include <google/protobuf/message.h>

#include <fstream>
#include <iostream>

#include "inou_firrtl.hpp"

#define PRINT_DEBUG

void Inou_firrtl::toFIRRTL(Eprp_var &var) {
  Inou_firrtl p(var);

  firrtl::FirrtlPB          fir_design;
  firrtl::FirrtlPB_Circuit *circuit = fir_design.add_circuit();
  auto                      top_msg = circuit->add_top();
  for (const auto &lnast : var.lnasts) {
    // lnast->ssa_trans();//FIXME: Do I need to do SSA?
    p.do_tofirrtl(lnast, circuit);
    top_msg->set_name(
        (std::string)lnast->get_name(lnast->get_root()));  // FIXME: Placeholder for now, need to figure out which LNAST is "top"
  }

  fir_design.PrintDebugString();
  std::fstream output(absl::StrCat(top_msg->name(), ".pb"), std::ios::out | std::ios::trunc | std::ios::binary);
  if (!fir_design.SerializeToOstream(&output)) {
    fmt::print("Failed to write firrtl design\n");
  }
  google::protobuf::ShutdownProtobufLibrary();
}

void Inou_firrtl::do_tofirrtl(std::shared_ptr<Lnast> ln, firrtl::FirrtlPB_Circuit *circuit) {
  const auto top      = ln->get_root();
  const auto stmts    = ln->get_first_child(top);
  const auto top_name = (std::string)ln->get_name(top);

  firrtl::FirrtlPB_Module *           mod  = circuit->add_module();
  firrtl::FirrtlPB_Module_UserModule *umod = new firrtl::FirrtlPB_Module_UserModule();
  umod->set_id(top_name);  // FIXME: Need to make sure top node has module name
  FindCircuitComps(*ln, umod);

  for (const auto &lnidx : ln->children(stmts)) {
    process_ln_stmt(*ln, lnidx, umod);
  }
  mod->set_allocated_user_module(umod);
}

void Inou_firrtl::process_ln_stmt(Lnast &ln, const Lnast_nid &lnidx, firrtl::FirrtlPB_Statement_When *when, uint8_t pos_to_add_to) {
  const auto ntype = ln.get_data(lnidx).type;
  if (ntype.is_assign() || ntype.is_dp_assign()) {
    auto fstmt       = pos_to_add_to == 0 ? when->add_consequent() : when->add_otherwise();
    auto stmt_needed = process_ln_assign_op(ln, lnidx, fstmt);
    if (!stmt_needed) {
      /*Note->hunter: If the assign returned false, then we
       * didn't need that assign so erase that statement made.*/
      if (pos_to_add_to == 0) {
        when->mutable_consequent()->RemoveLast();
      } else {
        when->mutable_otherwise()->RemoveLast();
      }
    }
  } else if (ntype.is_nary_op()) {
    auto fstmt = pos_to_add_to == 0 ? when->add_consequent() : when->add_otherwise();
    process_ln_nary_op(ln, lnidx, fstmt);
  } else if (ntype.is_not()) {
    auto fstmt = pos_to_add_to == 0 ? when->add_consequent() : when->add_otherwise();
    process_ln_not_op(ln, lnidx, fstmt);
    /*} else if (ntype.is_tuple_add()) {
      process_ast_tuple_add_op(dfg, lnidx);
    } else if (ntype.is_tuple_get()) {
      process_ast_tuple_get_op(dfg, lnidx);
    } else if (ntype.is_tuple_phi_add()) {
      process_ast_tuple_phi_add_op(dfg, lnidx);
    } else if (ntype.is_select()) {
      I(false); // should has been converted to tuple chain
    } else if (ntype.is_logical_op()) {
      process_ast_logical_op(dfg, lnidx);
    } else if (ntype.is_as()) {
      process_ast_as_op(dfg, lnidx);
    } else if (ntype.is_label()) {
      process_ast_label_op(dfg, lnidx);
    } else if (ntype.is_tuple()) {
      process_ast_tuple_struct(dfg, lnidx);
    } else if (ntype.is_tuple_concat()) {
      process_ast_concat_op(dfg, lnidx);*/
  } else if (ntype.is_if()) {
    add_cstmts(ln, lnidx, when, pos_to_add_to);
    auto nested_when_stmt = process_ln_if_op(ln, lnidx);
    auto fstmt            = pos_to_add_to == 0 ? when->add_consequent() : when->add_otherwise();
    fstmt->set_allocated_when(nested_when_stmt);
  } else if (ntype.is_range()) {
    process_ln_range_op(ln, lnidx);
  } else if (ntype.is_bit_select()) {
    auto fstmt = pos_to_add_to == 0 ? when->add_consequent() : when->add_otherwise();
    process_ln_bitsel_op(ln, lnidx, fstmt);
  } else if (ntype.is_dot()) {
    process_ln_dot(ln, lnidx);
  }
  /*} else if (ntype.is_func_call()) {
    process_ast_func_call_op(dfg, lnidx);
  } else if (ntype.is_func_def()) {
    process_ast_func_def_op(dfg, lnidx);
  } else if (ntype.is_for()) {
    process_ast_for_op(dfg, lnidx);
  } else if (ntype.is_while()) {
    process_ast_while_op(dfg, lnidx);
  }*/
  else if (ntype.is_invalid()) {
    return;
  } else if (ntype.is_const()) {
    I(ln.get_name(lnidx) == "default_const");
    return;
  } else if (ntype.is_err_flag()) {
    I(ln.get_name(lnidx) == "err_var_undefined");
    return;
  } else {
    I(false);
    return;
  }
}

/* TODO:
 *   dots (needed for signedness/subgraphs/pick)
 *   nodes needed for join_op
 *   nodes needed for pick_op: range_op bit_select
 *   nodes needed for subgraphs
 */
void Inou_firrtl::process_ln_stmt(Lnast &ln, const Lnast_nid &lnidx, firrtl::FirrtlPB_Module_UserModule *umod) {
  const auto ntype = ln.get_data(lnidx).type;
  if (ntype.is_assign() || ntype.is_dp_assign()) {
    auto fstmt       = umod->add_statement();
    auto stmt_needed = process_ln_assign_op(ln, lnidx, fstmt);
    if (!stmt_needed) {
      /*Note->hunter: If the assign returned false, then we
       * didn't need that assign so erase that statement made.*/
      umod->mutable_statement()->RemoveLast();
    }
  } else if (ntype.is_nary_op()) {
    auto fstmt = umod->add_statement();
    process_ln_nary_op(ln, lnidx, fstmt);
  } else if (ntype.is_not()) {
    auto fstmt = umod->add_statement();
    process_ln_not_op(ln, lnidx, fstmt);
    /*} else if (ntype.is_tuple_add()) {
      process_ast_tuple_add_op(dfg, lnidx);
    } else if (ntype.is_tuple_get()) {
      process_ast_tuple_get_op(dfg, lnidx);
    } else if (ntype.is_tuple_phi_add()) {
      process_ast_tuple_phi_add_op(dfg, lnidx);
    } else if (ntype.is_select()) {
      I(false); // should has been converted to tuple chain
    } else if (ntype.is_logical_op()) {
      process_ast_logical_op(dfg, lnidx);
    } else if (ntype.is_as()) {
      process_ast_as_op(dfg, lnidx);
    } else if (ntype.is_label()) {
      process_ast_label_op(dfg, lnidx);
    } else if (ntype.is_tuple()) {
      process_ast_tuple_struct(dfg, lnidx);
    } else if (ntype.is_tuple_concat()) {
      process_ast_concat_op(dfg, lnidx);*/
  } else if (ntype.is_if()) {
    add_cstmts(ln, lnidx, umod);
    auto when_stmt = process_ln_if_op(ln, lnidx);
    auto fstmt     = umod->add_statement();
    fstmt->set_allocated_when(when_stmt);
  } else if (ntype.is_range()) {
    process_ln_range_op(ln, lnidx);
  } else if (ntype.is_bit_select()) {
    auto fstmt = umod->add_statement();
    process_ln_bitsel_op(ln, lnidx, fstmt);
  } else if (ntype.is_dot()) {
    // FIXME: FILL
    process_ln_dot(ln, lnidx);
  }
  /*} else if (ntype.is_func_call()) {
    process_ast_func_call_op(dfg, lnidx);
  } else if (ntype.is_func_def()) {
    process_ast_func_def_op(dfg, lnidx);
  } else if (ntype.is_for()) {
    process_ast_for_op(dfg, lnidx);
  } else if (ntype.is_while()) {
    process_ast_while_op(dfg, lnidx);
  }*/
  else if (ntype.is_invalid()) {
    return;
  } else if (ntype.is_const()) {
    I(ln.get_name(lnidx) == "default_const");
    return;
  } else if (ntype.is_err_flag()) {
    I(ln.get_name(lnidx) == "err_var_undefined");
    return;
  } else {
    I(false);
    return;
  }
}

bool Inou_firrtl::process_ln_assign_op(Lnast &ln, const Lnast_nid &lnidx_assign, firrtl::FirrtlPB_Statement *fstmt) {
  auto c0       = ln.get_first_child(lnidx_assign);
  auto c1       = ln.get_sibling_next(c0);
  auto ntype_c0 = ln.get_type(c0);
  I(ntype_c0.is_ref());
  auto ntype_c1 = ln.get_type(c1);
  I(ntype_c1.is_const() || ntype_c1.is_ref());

  if (dot_map.contains(ln.get_name(c0))) {
    auto field_node = dot_map[ln.get_name(c0)].second;
    if (ln.get_name(field_node).substr(0, 2) == "__") {
      // This isn't an actual assign, and is instead assigning an attribute.
      handle_attr_assign(ln, c0, c1);
      return false;
    }
  }

  // Form expression that holds RHS contents.
  firrtl::FirrtlPB_Expression *rhs_expr = new firrtl::FirrtlPB_Expression();
  add_refcon_as_expr(ln, c1, rhs_expr);

  // Now assign lhs to rhs.
  make_assignment(ln, c0, rhs_expr, fstmt);
  return true;
}

void Inou_firrtl::process_ln_not_op(Lnast &ln, const Lnast_nid &lnidx_not, firrtl::FirrtlPB_Statement *fstmt) {
  auto c0       = ln.get_first_child(lnidx_not);
  auto c1       = ln.get_sibling_next(c0);
  auto ntype_c0 = ln.get_type(c0);
  I(ntype_c0.is_ref());
  auto ntype_c1 = ln.get_type(c1);
  I(ntype_c1.is_const() || ntype_c1.is_ref());

  // Form expression that holds RHS contents.
  firrtl::FirrtlPB_Expression *       rhs_expr    = new firrtl::FirrtlPB_Expression();
  firrtl::FirrtlPB_Expression_PrimOp *rhs_prim_op = new firrtl::FirrtlPB_Expression_PrimOp();
  rhs_prim_op->set_op(firrtl::FirrtlPB_Expression_PrimOp_Op_OP_BIT_NOT);

  add_refcon_as_expr(ln, c1, rhs_prim_op->add_arg());
  rhs_expr->set_allocated_prim_op(rhs_prim_op);

  // Now assign lhs to rhs.
  make_assignment(ln, c0, rhs_expr, fstmt);
}

void Inou_firrtl::process_ln_nary_op(Lnast &ln, const Lnast_nid &lnidx_op, firrtl::FirrtlPB_Statement *fstmt) {
  bool        first     = true;
  bool        first_arg = true;
  std::string lhs, rhs;
  uint8_t     child_count = 0;

  auto firrtl_oper_code = get_firrtl_oper_code(ln.get_data(lnidx_op).type);

  // Grab the LHS for later use. Also create PrimOP for RHS expr.
  Lnast_nid                           lnidx_lhs;
  firrtl::FirrtlPB_Expression_PrimOp *rhs_prim_op      = NULL;
  firrtl::FirrtlPB_Expression *       rhs_expr         = NULL;
  firrtl::FirrtlPB_Expression *       rhs_highest_expr = NULL;
  for (const auto &lnchild_idx : ln.children(lnidx_op)) {
    if (first) {
      first     = false;
      lnidx_lhs = lnchild_idx;
    } else if (lnchild_idx == ln.get_last_child(lnidx_op)) {
      // If this is the last element, don't create another new operator.
      add_refcon_as_expr(ln, lnchild_idx, rhs_prim_op->add_arg());
    } else {
      // If this is not the last element, we'll need another operator to grab next element.

      // This is pretty dense code so here's the concept:
      // 1. Create new rhs_expr. (if first, create a holder so we don't lose it)
      // 2. Create new prim_op (rhs_prim_op) underneath the new expression.
      // 3. Attach const/ref arg to this (rhs_prim_op).
      if (first_arg) {
        first_arg        = false;
        rhs_expr         = new firrtl::FirrtlPB_Expression();
        rhs_highest_expr = rhs_expr;
      } else {
        rhs_expr = rhs_prim_op->add_arg();
      }
      rhs_prim_op = new firrtl::FirrtlPB_Expression_PrimOp();
      rhs_prim_op->set_op(firrtl_oper_code);
      rhs_expr->set_allocated_prim_op(rhs_prim_op);

      // Add current child node as member of the primitive op (rhs_prim_op)
      add_refcon_as_expr(ln, lnchild_idx, rhs_prim_op->add_arg());
    }
    child_count++;
  }

  auto ntype = ln.get_data(lnidx_op).type;
  if (ntype.is_ge() || ntype.is_gt() || ntype.is_le() || ntype.is_lt()) {
    I(child_count == 3);  // I think there should only be 1 output + 2 inputs to a comp node.
  }

  // Now assign lhs to rhs.
  make_assignment(ln, lnidx_lhs, rhs_highest_expr, fstmt);
}

/* Assign LHS to RHS Determines whether LHS is intermediate or not.
 * If so, make assignment type: node. Otherwise, do normal connect. */
void Inou_firrtl::make_assignment(Lnast &ln, const Lnast_nid &lnidx_lhs, firrtl::FirrtlPB_Expression *expr_rhs,
                                  firrtl::FirrtlPB_Statement *fstmt) {
  if (is_outp(ln.get_name(lnidx_lhs)) || is_reg(ln.get_name(lnidx_lhs)) || is_wire(ln.get_name(lnidx_lhs))) {
    create_connect_stmt(ln, lnidx_lhs, expr_rhs, fstmt);

  } else {
    /* If I'm assigning to some wire/intermediate,
     * this should make FIRRTL node statement. */
    create_node_stmt(ln, lnidx_lhs, expr_rhs, fstmt);
  }
}

void Inou_firrtl::add_cstmts(Lnast &ln, const Lnast_nid &lnidx_if, firrtl::FirrtlPB_Module_UserModule *umod) {
  for (const auto &if_child : ln.children(lnidx_if)) {
    const auto ntype = ln.get_data(if_child).type;
    if (ntype.is_cstmts()) {
      process_ln_stmt(ln, if_child, umod);
    }
  }
}

void Inou_firrtl::add_cstmts(Lnast &ln, const Lnast_nid &lnidx_if, firrtl::FirrtlPB_Statement_When *when, uint8_t pos_to_add_to) {
  for (const auto &if_child : ln.children(lnidx_if)) {
    const auto ntype = ln.get_data(if_child).type;
    if (ntype.is_cstmts()) {
      process_ln_stmt(ln, if_child, when, pos_to_add_to);
    }
  }
}

firrtl::FirrtlPB_Statement_When *Inou_firrtl::process_ln_if_op(Lnast &ln, const Lnast_nid &lnidx_if) {
  auto    when_highest  = new firrtl::FirrtlPB_Statement_When();
  auto    when_lowest   = when_highest;
  uint8_t pos_to_add_to = 0;  // 0 indicates add to when_lowest's consequent, 1 means add to otherwise
  for (const auto &if_child : ln.children(lnidx_if)) {
    const auto ntype = ln.get_data(if_child).type;
    if (ntype.is_stmts()) {
      process_ln_stmt(ln, if_child, when_lowest, pos_to_add_to);
      pos_to_add_to++;  // Set to 1 (or 2 if last stmt)
    } else if (ntype.is_cond()) {
      // A new cond has been found, meaning we need to create another when
      if (pos_to_add_to == 1) {
        auto new_when = new firrtl::FirrtlPB_Statement_When();
        auto new_stmt = when_lowest->add_otherwise();
        new_stmt->set_allocated_when(new_when);
        when_lowest   = new_when;
        pos_to_add_to = 0;
      }
      // Specify the 'predicate' (condition)
      auto predicate = new firrtl::FirrtlPB_Expression();
      add_refcon_as_expr(ln, if_child, predicate);
      when_lowest->set_allocated_predicate(predicate);
    } else if (ntype.is_cstmts()) {
      continue;
    } else {
      I(false);  // FIXME->hunter: Should phi or anything else be acceptable here?
    }
  }

  return when_highest;
}

/* Since the range op only indicates that there is a
 * value range from the low value to the high value,
 * this is added to a map for later access. */
// Note->hunter: This only accepts positive values, and not LNAST's negative range capability.
void Inou_firrtl::process_ln_range_op(Lnast &ln, const Lnast_nid &lnidx_range) {
  auto lhs_node = ln.get_first_child(lnidx_range);
  auto range_lo = ln.get_sibling_next(lhs_node);
  auto range_hi = ln.get_sibling_next(range_lo);

  name_to_range_map[ln.get_name(lhs_node)] = {range_lo, range_hi};
}

void Inou_firrtl::process_ln_bitsel_op(Lnast &ln, const Lnast_nid &lnidx_bitsel, firrtl::FirrtlPB_Statement *fstmt) {
  auto lhs_node  = ln.get_first_child(lnidx_bitsel);
  auto elem_node = ln.get_sibling_next(lhs_node);
  auto range_acc = ln.get_sibling_next(elem_node);

  auto range_pair = name_to_range_map[ln.get_name(range_acc)];
  // Note->hunter: FIRRTL requires range values to be constant numbers.
  I(ln.get_data(range_pair.first).type.is_const() && ln.get_data(range_pair.second).type.is_const());

  // Create rhs expr, make if a prim op of type "extract bits"
  firrtl::FirrtlPB_Expression *       rhs_expr         = new firrtl::FirrtlPB_Expression();
  auto                                firrtl_oper_code = get_firrtl_oper_code(ln.get_data(lnidx_bitsel).type);
  firrtl::FirrtlPB_Expression_PrimOp *rhs_prim_op      = new firrtl::FirrtlPB_Expression_PrimOp();
  rhs_prim_op->set_op(firrtl_oper_code);

  // Add arguments to "EXTRACT_BITS" op
  add_refcon_as_expr(ln, elem_node, rhs_prim_op->add_arg());
  add_const_as_ilit(ln, range_pair.second, rhs_prim_op->add_const_());
  add_const_as_ilit(ln, range_pair.first, rhs_prim_op->add_const_());
  rhs_expr->set_allocated_prim_op(rhs_prim_op);

  // Now assign lhs to rhs.
  make_assignment(ln, lhs_node, rhs_expr, fstmt);
}

void Inou_firrtl::process_ln_dot(Lnast &ln, const Lnast_nid &lnidx_dot) {
  auto lhs   = ln.get_first_child(lnidx_dot);
  auto tup   = ln.get_sibling_next(lhs);
  auto field = ln.get_sibling_next(tup);

  dot_map[ln.get_name(lhs)] = {tup, field};
}

void Inou_firrtl::handle_attr_assign(Lnast &ln, const Lnast_nid &lhs, const Lnast_nid &rhs) {
  auto pair      = dot_map[ln.get_name(lhs)];
  auto var       = pair.first;
  auto var_name  = ln.get_name(var);
  auto attr      = pair.second;
  auto attr_name = ln.get_name(attr);

  // TODO: __signed __posedge ...
  if (attr_name == "__clk_pin") {
    handle_clock_attr(ln, var_name, rhs);
  } else {
    fmt::print("Error: attribute found, but it is either incorrect or not supported yet.\n");
    // I(false);
  }
}

void Inou_firrtl::handle_clock_attr(Lnast &ln, const std::string_view &var_name, const Lnast_nid &rhs) {
  I(reg_wire_map.contains(var_name.substr(1)));
  auto stmt = reg_wire_map[var_name.substr(1)];
  I(stmt->has_register_());
  auto reg = stmt->mutable_register_();

  /* Now we need to set whatever is represented by var_name to have type Clock.
   * If it's a circuit component, then just change the type to be clock. If it's
   * not, then we have to create as asClock expression to convert the intermediate */
  // FIXME: Perhaps I should add checks to make sure changing this to Clock won't break something else.
  auto clk_name = ln.get_name(rhs);
  if (io_map.contains(clk_name.substr(1))) {
    auto port_ptr = io_map[clk_name.substr(1)];
    auto clk_type = new firrtl::FirrtlPB_Type_ClockType();
    auto type     = new firrtl::FirrtlPB_Type();
    type->set_allocated_clock_type(clk_type);
    port_ptr->set_allocated_type(type);

  } else if (reg_wire_map.contains(clk_name.substr(1))) {
    auto stmt_ptr = reg_wire_map[clk_name.substr(1)];
    auto clk_type = new firrtl::FirrtlPB_Type_ClockType();
    auto type     = new firrtl::FirrtlPB_Type();
    type->set_allocated_clock_type(clk_type);
    stmt_ptr->mutable_register_()->set_allocated_type(type);

  } else if (reg_wire_map.contains(clk_name)) {
    auto stmt_ptr = reg_wire_map[clk_name.substr(1)];
    auto clk_type = new firrtl::FirrtlPB_Type_ClockType();
    auto type     = new firrtl::FirrtlPB_Type();
    type->set_allocated_clock_type(clk_type);
    stmt_ptr->mutable_wire()->set_allocated_type(type);

  } else {
    // FIXME: Create asClock here to change rhs name to clock (then use that as expr for clock field
    firrtl::FirrtlPB_Expression_PrimOp *prim = new firrtl::FirrtlPB_Expression_PrimOp();
    prim->set_op(firrtl::FirrtlPB_Expression_PrimOp_Op_OP_AS_CLOCK);
    auto arg = prim->add_arg();
    add_refcon_as_expr(ln, rhs, arg);
    firrtl::FirrtlPB_Expression *expr = new firrtl::FirrtlPB_Expression();
    expr->set_allocated_prim_op(prim);

    reg->set_allocated_clock(expr);
    return;  // Don't do final step, since we did actual assignment on previous line
  }

  // Set the register's clock.
  firrtl::FirrtlPB_Expression *clk_expr = new firrtl::FirrtlPB_Expression();
  add_refcon_as_expr(ln, rhs, clk_expr);
  reg->set_allocated_clock(clk_expr);
}

//----- Helper Functions -----
bool Inou_firrtl::is_inp(const std::string_view str) { return str.substr(0, 1) == "$"; }

bool Inou_firrtl::is_outp(const std::string_view str) { return str.substr(0, 1) == "%"; }

bool Inou_firrtl::is_reg(const std::string_view str) { return str.substr(0, 1) == "#"; }

bool Inou_firrtl::is_wire(const std::string_view str) {
  // Anything that doesn't have a prefix
  auto first_char = str.substr(0, 1);
  return !(str.substr(0, 3) == "___") && !(first_char == "#") && !(first_char == "$") && !(first_char == "%");
}

std::string Inou_firrtl::get_firrtl_name_format(Lnast &ln, const Lnast_nid &lnidx) {
  auto                   ntype = ln.get_type(lnidx);
  const std::string_view str   = ln.get_name(lnidx);
  if (ntype.is_ref() || ntype.is_cond()) {
    return strip_prefixes(str);
  } else if (ntype.is_const()) {
    auto lconst_holder = Lconst(ln.get_name(lnidx));
    return lconst_holder.to_firrtl();
  }
  fmt::print("{}\n", str);
  I(false);  // When getting names, I would think we should only be checking those two node types.
  return "";
}

std::string Inou_firrtl::strip_prefixes(const std::string_view str) {
  std::string temp = (std::string)str;
  while ((temp.substr(0, 1) == "$") || (temp.substr(0, 1) == "%") || (temp.substr(0, 1) == "#")) {
    temp.replace(0, 1, "");  // Remove first char from a string
  }

  if (temp.substr(0, 3) == "_._") {
    temp = temp.substr(2);
  }

  return temp;
}

/* If the LHS of some sort of statement that does assigning
 * is a register or an output, then the statement needs to
 * be treated as a FIRRTL "connect" statement. */
void Inou_firrtl::create_connect_stmt(Lnast &ln, const Lnast_nid &lhs, firrtl::FirrtlPB_Expression *rhs_expr,
                                      firrtl::FirrtlPB_Statement *fstmt) {
  firrtl::FirrtlPB_Expression_Reference *lhs_ref = new firrtl::FirrtlPB_Expression_Reference();
  lhs_ref->set_id(get_firrtl_name_format(ln, lhs));

  firrtl::FirrtlPB_Expression *lhs_expr = new firrtl::FirrtlPB_Expression();
  lhs_expr->set_allocated_reference(lhs_ref);

  firrtl::FirrtlPB_Statement_Connect *conn = new firrtl::FirrtlPB_Statement_Connect();
  conn->set_allocated_location(lhs_expr);
  conn->set_allocated_expression(rhs_expr);

  fstmt->set_allocated_connect(conn);
}

/* If the LHS of some sort of statement that does assigning
 * is not a register or an output or a wire, then the statement
 * needs to be treated as a FIRRTL "node" statement. */
void Inou_firrtl::create_node_stmt(Lnast &ln, const Lnast_nid &lhs, firrtl::FirrtlPB_Expression *rhs_expr,
                                   firrtl::FirrtlPB_Statement *fstmt) {
  firrtl::FirrtlPB_Statement_Node *node = new firrtl::FirrtlPB_Statement_Node();
  node->set_id((std::string)ln.get_name(lhs));
  node->set_allocated_expression(rhs_expr);

  fstmt->set_allocated_node(node);
}

firrtl::FirrtlPB_Expression_PrimOp_Op Inou_firrtl::get_firrtl_oper_code(const Lnast_ntype &ntype) {
  if (ntype.is_plus()) {
    return firrtl::FirrtlPB_Expression_PrimOp_Op_OP_ADD;
  } else if (ntype.is_minus()) {
    return firrtl::FirrtlPB_Expression_PrimOp_Op_OP_SUB;
  } else if (ntype.is_mult()) {
    return firrtl::FirrtlPB_Expression_PrimOp_Op_OP_TIMES;
  } else if (ntype.is_div()) {
    return firrtl::FirrtlPB_Expression_PrimOp_Op_OP_DIVIDE;
    //} else if (ntype.is_rem()) { //FIXME: Modulo not yet implemented in LNAST
    //  firrtl_op = "rem";
  } else if (ntype.is_ge()) {
    return firrtl::FirrtlPB_Expression_PrimOp_Op_OP_GREATER_EQ;
  } else if (ntype.is_gt()) {
    return firrtl::FirrtlPB_Expression_PrimOp_Op_OP_GREATER;
  } else if (ntype.is_le()) {
    return firrtl::FirrtlPB_Expression_PrimOp_Op_OP_LESS_EQ;
  } else if (ntype.is_lt()) {
    return firrtl::FirrtlPB_Expression_PrimOp_Op_OP_LESS;
  } else if (ntype.is_same()) {
    return firrtl::FirrtlPB_Expression_PrimOp_Op_OP_EQUAL;
  } else if (ntype.is_and()) {
    return firrtl::FirrtlPB_Expression_PrimOp_Op_OP_BIT_AND;
  } else if (ntype.is_or()) {
    return firrtl::FirrtlPB_Expression_PrimOp_Op_OP_BIT_OR;
  } else if (ntype.is_xor()) {
    return firrtl::FirrtlPB_Expression_PrimOp_Op_OP_BIT_XOR;
  } else if (ntype.is_bit_select()) {
    return firrtl::FirrtlPB_Expression_PrimOp_Op_OP_EXTRACT_BITS;
  } else if (ntype.is_shift_left()) {
    return firrtl::FirrtlPB_Expression_PrimOp_Op_OP_DYNAMIC_SHIFT_LEFT;
  } else {
    I(false);  // some nary op not yet supported
    return firrtl::FirrtlPB_Expression_PrimOp_Op_OP_UNKNOWN;
  }
}

/* Provided some ref or const node and an expression pointer,
 * this will form that ref/const in the expression pointer. */
void Inou_firrtl::add_refcon_as_expr(Lnast &ln, const Lnast_nid &lnidx, firrtl::FirrtlPB_Expression *expr) {
  if (ln.get_data(lnidx).type.is_ref()) {
    // Lnidx is a variable, so I need to make a Reference argument.
    auto                                   str     = get_firrtl_name_format(ln, lnidx);
    firrtl::FirrtlPB_Expression_Reference *rhs_ref = new firrtl::FirrtlPB_Expression_Reference();
    rhs_ref->set_id(str);
    expr->set_allocated_reference(rhs_ref);

  } else if (ln.get_data(lnidx).type.is_const()) {
    // Lnidx is a number, so I need to make a [U/S]IntLiteral argument.
    auto lconst_holder = Lconst(ln.get_name(lnidx));
    auto lconst_str    = lconst_holder.to_firrtl();

    firrtl::FirrtlPB_Expression_IntegerLiteral *num = new firrtl::FirrtlPB_Expression_IntegerLiteral();
    num->set_value(lconst_str);
    firrtl::FirrtlPB_Width *width = new firrtl::FirrtlPB_Width();
    width->set_value(lconst_holder.get_bits());

    if (lconst_holder.is_unsigned()) {
      firrtl::FirrtlPB_Expression_UIntLiteral *ulit = new firrtl::FirrtlPB_Expression_UIntLiteral();
      ulit->set_allocated_value(num);
      ulit->set_allocated_width(width);
      expr->set_allocated_uint_literal(ulit);
    } else {
      firrtl::FirrtlPB_Expression_SIntLiteral *slit = new firrtl::FirrtlPB_Expression_SIntLiteral();
      slit->set_allocated_value(num);
      slit->set_allocated_width(width);
      expr->set_allocated_sint_literal(slit);
    }

  } else {
    I(false);  // Should const and ref be only things allowed on RHS?
  }
}

/* Provided a const node and an IntegerLit pointer,
 * this will form that const in the pointer. */
void Inou_firrtl::add_const_as_ilit(Lnast &ln, const Lnast_nid &lnidx, firrtl::FirrtlPB_Expression_IntegerLiteral *ilit) {
  I(ln.get_data(lnidx).type.is_const());

  auto lconst_holder = Lconst(ln.get_name(lnidx));
  auto lconst_str    = lconst_holder.to_firrtl();

  ilit->set_value(lconst_str);
}
