
��
��
BreakpointUnit_4
clock" 
reset
�
io�*�
�status�*�
debug

cease

wfi

isa
 
dprv

prv

sd

zero2

sxl

uxl

sd_rv32

zero1

tsr

tw

tvm

mxr

sum

mprv

xs

fs

mpp

vs

spp

mpie

hpie

spie

upie

mie

hie

sie

uie

�bp�2�
�*�
�control�*�
ttype

dmode

maskmax

reserved
(
action

chain

zero

tmatch

m

h

s

u

x

w

r

address
'
pc
'
ea
'
xcpt_if

xcpt_ld

xcpt_st

debug_if

debug_ld

debug_st

�bpwatchw2u
s*q
valid2



rvalid2



wvalid2



ivalid2



action
?z"
:


ioxcpt_if	

0�Breakpoint.scala 74:14?z"
:


ioxcpt_ld	

0�Breakpoint.scala 75:14?z"
:


ioxcpt_st	

0�Breakpoint.scala 76:14@z#
:


iodebug_if	

0�Breakpoint.scala 77:15@z#
:


iodebug_ld	

0�Breakpoint.scala 78:15@z#
:


iodebug_st	

0�Breakpoint.scala 79:15
����
MemAddrCalcUnit
clock" 
reset
�W
io�W*�W
�req�*�
ready

valid

�bits�*�
�uop�*�
uopc

inst
 

debug_inst
 
is_rvc

debug_pc
(
iq_type

fu_code


�ctrl�*�
br_type

op1_sel

op2_sel

imm_sel

op_fcn

fcn_dw

csr_cmd

is_load

is_sta

is_std

iw_state

iw_p1_poisoned

iw_p2_poisoned

is_br

is_jalr

is_jal

is_sfb

br_mask

br_tag

ftq_idx

	edge_inst

pc_lob

taken


imm_packed

csr_addr

rob_idx

ldq_idx

stq_idx

rxq_idx

pdst

prs1

prs2

prs3

ppred

	prs1_busy

	prs2_busy

	prs3_busy


ppred_busy


stale_pdst

	exception

	exc_cause
@

bypassable

mem_cmd

mem_size


mem_signed

is_fence

	is_fencei

is_amo

uses_ldq

uses_stq

is_sys_pc2epc

	is_unique

flush_on_commit

ldst_is_rs1

ldst

lrs1

lrs2

lrs3

ldst_val

	dst_rtype


lrs1_rtype


lrs2_rtype

frs3_en

fp_val

	fp_single


xcpt_pf_if


xcpt_ae_if


xcpt_ma_if

bp_debug_if


bp_xcpt_if


debug_fsrc


debug_tsrc

rs1_data
A
rs2_data
A
rs3_data
A
	pred_data

kill

�resp�*�
ready

valid

�bits�*�
�uop�*�
uopc

inst
 

debug_inst
 
is_rvc

debug_pc
(
iq_type

fu_code


�ctrl�*�
br_type

op1_sel

op2_sel

imm_sel

op_fcn

fcn_dw

csr_cmd

is_load

is_sta

is_std

iw_state

iw_p1_poisoned

iw_p2_poisoned

is_br

is_jalr

is_jal

is_sfb

br_mask

br_tag

ftq_idx

	edge_inst

pc_lob

taken


imm_packed

csr_addr

rob_idx

ldq_idx

stq_idx

rxq_idx

pdst

prs1

prs2

prs3

ppred

	prs1_busy

	prs2_busy

	prs3_busy


ppred_busy


stale_pdst

	exception

	exc_cause
@

bypassable

mem_cmd

mem_size


mem_signed

is_fence

	is_fencei

is_amo

uses_ldq

uses_stq

is_sys_pc2epc

	is_unique

flush_on_commit

ldst_is_rs1

ldst

lrs1

lrs2

lrs3

ldst_val

	dst_rtype


lrs1_rtype


lrs2_rtype

frs3_en

fp_val

	fp_single


xcpt_pf_if


xcpt_ae_if


xcpt_ma_if

bp_debug_if


bp_xcpt_if


debug_fsrc


debug_tsrc


predicated

data
A
�fflags�*�
valid

�bits�*�
�uop�*�
uopc

inst
 

debug_inst
 
is_rvc

debug_pc
(
iq_type

fu_code


�ctrl�*�
br_type

op1_sel

op2_sel

imm_sel

op_fcn

fcn_dw

csr_cmd

is_load

is_sta

is_std

iw_state

iw_p1_poisoned

iw_p2_poisoned

is_br

is_jalr

is_jal

is_sfb

br_mask

br_tag

ftq_idx

	edge_inst

pc_lob

taken


imm_packed

csr_addr

rob_idx

ldq_idx

stq_idx

rxq_idx

pdst

prs1

prs2

prs3

ppred

	prs1_busy

	prs2_busy

	prs3_busy


ppred_busy


stale_pdst

	exception

	exc_cause
@

bypassable

mem_cmd

mem_size


mem_signed

is_fence

	is_fencei

is_amo

uses_ldq

uses_stq

is_sys_pc2epc

	is_unique

flush_on_commit

ldst_is_rs1

ldst

lrs1

lrs2

lrs3

ldst_val

	dst_rtype


lrs1_rtype


lrs2_rtype

frs3_en

fp_val

	fp_single


xcpt_pf_if


xcpt_ae_if


xcpt_ma_if

bp_debug_if


bp_xcpt_if


debug_fsrc


debug_tsrc

flags

addr
(
,mxcpt#*!
valid

bits

gsfence]*[
valid

Hbits@*>
rs1

rs2

addr
'
asid

�brupdate�*�
;b15*3
resolve_mask

mispredict_mask

�b2�*�
�uop�*�
uopc

inst
 

debug_inst
 
is_rvc

debug_pc
(
iq_type

fu_code


�ctrl�*�
br_type

op1_sel

op2_sel

imm_sel

op_fcn

fcn_dw

csr_cmd

is_load

is_sta

is_std

iw_state

iw_p1_poisoned

iw_p2_poisoned

is_br

is_jalr

is_jal

is_sfb

br_mask

br_tag

ftq_idx

	edge_inst

pc_lob

taken


imm_packed

csr_addr

rob_idx

ldq_idx

stq_idx

rxq_idx

pdst

prs1

prs2

prs3

ppred

	prs1_busy

	prs2_busy

	prs3_busy


ppred_busy


stale_pdst

	exception

	exc_cause
@

bypassable

mem_cmd

mem_size


mem_signed

is_fence

	is_fencei

is_amo

uses_ldq

uses_stq

is_sys_pc2epc

	is_unique

flush_on_commit

ldst_is_rs1

ldst

lrs1

lrs2

lrs3

ldst_val

	dst_rtype


lrs1_rtype


lrs2_rtype

frs3_en

fp_val

	fp_single


xcpt_pf_if


xcpt_ae_if


xcpt_ma_if

bp_debug_if


bp_xcpt_if


debug_fsrc


debug_tsrc

valid


mispredict

taken

cfi_type

pc_sel

jalr_target
(
target_offset

�bypass�2�
�*�
valid

�bits�*�
�uop�*�
uopc

inst
 

debug_inst
 
is_rvc

debug_pc
(
iq_type

fu_code


�ctrl�*�
br_type

op1_sel

op2_sel

imm_sel

op_fcn

fcn_dw

csr_cmd

is_load

is_sta

is_std

iw_state

iw_p1_poisoned

iw_p2_poisoned

is_br

is_jalr

is_jal

is_sfb

br_mask

br_tag

ftq_idx

	edge_inst

pc_lob

taken


imm_packed

csr_addr

rob_idx

ldq_idx

stq_idx

rxq_idx

pdst

prs1

prs2

prs3

ppred

	prs1_busy

	prs2_busy

	prs3_busy


ppred_busy


stale_pdst

	exception

	exc_cause
@

bypassable

mem_cmd

mem_size


mem_signed

is_fence

	is_fencei

is_amo

uses_ldq

uses_stq

is_sys_pc2epc

	is_unique

flush_on_commit

ldst_is_rs1

ldst

lrs1

lrs2

lrs3

ldst_val

	dst_rtype


lrs1_rtype


lrs2_rtype

frs3_en

fp_val

	fp_single


xcpt_pf_if


xcpt_ae_if


xcpt_ma_if

bp_debug_if


bp_xcpt_if


debug_fsrc


debug_tsrc

data
A

predicated

�fflags�*�
valid

�bits�*�
�uop�*�
uopc

inst
 

debug_inst
 
is_rvc

debug_pc
(
iq_type

fu_code


�ctrl�*�
br_type

op1_sel

op2_sel

imm_sel

op_fcn

fcn_dw

csr_cmd

is_load

is_sta

is_std

iw_state

iw_p1_poisoned

iw_p2_poisoned

is_br

is_jalr

is_jal

is_sfb

br_mask

br_tag

ftq_idx

	edge_inst

pc_lob

taken


imm_packed

csr_addr

rob_idx

ldq_idx

stq_idx

rxq_idx

pdst

prs1

prs2

prs3

ppred

	prs1_busy

	prs2_busy

	prs3_busy


ppred_busy


stale_pdst

	exception

	exc_cause
@

bypassable

mem_cmd

mem_size


mem_signed

is_fence

	is_fencei

is_amo

uses_ldq

uses_stq

is_sys_pc2epc

	is_unique

flush_on_commit

ldst_is_rs1

ldst

lrs1

lrs2

lrs3

ldst_val

	dst_rtype


lrs1_rtype


lrs2_rtype

frs3_en

fp_val

	fp_single


xcpt_pf_if


xcpt_ae_if


xcpt_ma_if

bp_debug_if


bp_xcpt_if


debug_fsrc


debug_tsrc

flags

�status�*�
debug

cease

wfi

isa
 
dprv

prv

sd

zero2

sxl

uxl

sd_rv32

zero1

tsr

tw

tvm

mxr

sum

mprv

xs

fs

mpp

vs

spp

mpie

hpie

spie

upie

mie

hie

sie

uie

�bp�2�
�*�
�control�*�
ttype

dmode

maskmax

reserved
(
action

chain

zero

tmatch

m

h

s

u

x

w

r

address
'�
	

clock�
 �
	

reset�
 �


io�
 Lz)
:
:


ioreqready	

1�functional-unit.scala 223:16�2n
_ThRf1:/
:
:


iobrupdateb1mispredict_mask/:-
": 
:
:


ioreqbitsuopbr_mask�util.scala 118:5192!
_T_1R

_T	

0�util.scala 118:59F2#
_T_2R

_T_1	

0�functional-unit.scala 266:41U22
_T_3*R(:
:


ioreqvalid

_T_2�functional-unit.scala 266:38Jz'
:
:


iorespvalid

_T_3�functional-unit.scala 266:22\z9
*:(
:
:


iorespbits
predicated	

0�functional-unit.scala 267:29�zi
3:1
#:!
:
:


iorespbitsuop
debug_tsrc2:0
": 
:
:


ioreqbitsuop
debug_tsrc�functional-unit.scala 268:22�zi
3:1
#:!
:
:


iorespbitsuop
debug_fsrc2:0
": 
:
:


ioreqbitsuop
debug_fsrc�functional-unit.scala 268:22�zi
3:1
#:!
:
:


iorespbitsuop
bp_xcpt_if2:0
": 
:
:


ioreqbitsuop
bp_xcpt_if�functional-unit.scala 268:22�zk
4:2
#:!
:
:


iorespbitsuopbp_debug_if3:1
": 
:
:


ioreqbitsuopbp_debug_if�functional-unit.scala 268:22�zi
3:1
#:!
:
:


iorespbitsuop
xcpt_ma_if2:0
": 
:
:


ioreqbitsuop
xcpt_ma_if�functional-unit.scala 268:22�zi
3:1
#:!
:
:


iorespbitsuop
xcpt_ae_if2:0
": 
:
:


ioreqbitsuop
xcpt_ae_if�functional-unit.scala 268:22�zi
3:1
#:!
:
:


iorespbitsuop
xcpt_pf_if2:0
": 
:
:


ioreqbitsuop
xcpt_pf_if�functional-unit.scala 268:22�zg
2:0
#:!
:
:


iorespbitsuop	fp_single1:/
": 
:
:


ioreqbitsuop	fp_single�functional-unit.scala 268:22�za
/:-
#:!
:
:


iorespbitsuopfp_val.:,
": 
:
:


ioreqbitsuopfp_val�functional-unit.scala 268:22�zc
0:.
#:!
:
:


iorespbitsuopfrs3_en/:-
": 
:
:


ioreqbitsuopfrs3_en�functional-unit.scala 268:22�zi
3:1
#:!
:
:


iorespbitsuop
lrs2_rtype2:0
": 
:
:


ioreqbitsuop
lrs2_rtype�functional-unit.scala 268:22�zi
3:1
#:!
:
:


iorespbitsuop
lrs1_rtype2:0
": 
:
:


ioreqbitsuop
lrs1_rtype�functional-unit.scala 268:22�zg
2:0
#:!
:
:


iorespbitsuop	dst_rtype1:/
": 
:
:


ioreqbitsuop	dst_rtype�functional-unit.scala 268:22�ze
1:/
#:!
:
:


iorespbitsuopldst_val0:.
": 
:
:


ioreqbitsuopldst_val�functional-unit.scala 268:22�z]
-:+
#:!
:
:


iorespbitsuoplrs3,:*
": 
:
:


ioreqbitsuoplrs3�functional-unit.scala 268:22�z]
-:+
#:!
:
:


iorespbitsuoplrs2,:*
": 
:
:


ioreqbitsuoplrs2�functional-unit.scala 268:22�z]
-:+
#:!
:
:


iorespbitsuoplrs1,:*
": 
:
:


ioreqbitsuoplrs1�functional-unit.scala 268:22�z]
-:+
#:!
:
:


iorespbitsuopldst,:*
": 
:
:


ioreqbitsuopldst�functional-unit.scala 268:22�zk
4:2
#:!
:
:


iorespbitsuopldst_is_rs13:1
": 
:
:


ioreqbitsuopldst_is_rs1�functional-unit.scala 268:22�zs
8:6
#:!
:
:


iorespbitsuopflush_on_commit7:5
": 
:
:


ioreqbitsuopflush_on_commit�functional-unit.scala 268:22�zg
2:0
#:!
:
:


iorespbitsuop	is_unique1:/
": 
:
:


ioreqbitsuop	is_unique�functional-unit.scala 268:22�zo
6:4
#:!
:
:


iorespbitsuopis_sys_pc2epc5:3
": 
:
:


ioreqbitsuopis_sys_pc2epc�functional-unit.scala 268:22�ze
1:/
#:!
:
:


iorespbitsuopuses_stq0:.
": 
:
:


ioreqbitsuopuses_stq�functional-unit.scala 268:22�ze
1:/
#:!
:
:


iorespbitsuopuses_ldq0:.
": 
:
:


ioreqbitsuopuses_ldq�functional-unit.scala 268:22�za
/:-
#:!
:
:


iorespbitsuopis_amo.:,
": 
:
:


ioreqbitsuopis_amo�functional-unit.scala 268:22�zg
2:0
#:!
:
:


iorespbitsuop	is_fencei1:/
": 
:
:


ioreqbitsuop	is_fencei�functional-unit.scala 268:22�ze
1:/
#:!
:
:


iorespbitsuopis_fence0:.
": 
:
:


ioreqbitsuopis_fence�functional-unit.scala 268:22�zi
3:1
#:!
:
:


iorespbitsuop
mem_signed2:0
": 
:
:


ioreqbitsuop
mem_signed�functional-unit.scala 268:22�ze
1:/
#:!
:
:


iorespbitsuopmem_size0:.
": 
:
:


ioreqbitsuopmem_size�functional-unit.scala 268:22�zc
0:.
#:!
:
:


iorespbitsuopmem_cmd/:-
": 
:
:


ioreqbitsuopmem_cmd�functional-unit.scala 268:22�zi
3:1
#:!
:
:


iorespbitsuop
bypassable2:0
": 
:
:


ioreqbitsuop
bypassable�functional-unit.scala 268:22�zg
2:0
#:!
:
:


iorespbitsuop	exc_cause1:/
": 
:
:


ioreqbitsuop	exc_cause�functional-unit.scala 268:22�zg
2:0
#:!
:
:


iorespbitsuop	exception1:/
": 
:
:


ioreqbitsuop	exception�functional-unit.scala 268:22�zi
3:1
#:!
:
:


iorespbitsuop
stale_pdst2:0
": 
:
:


ioreqbitsuop
stale_pdst�functional-unit.scala 268:22�zi
3:1
#:!
:
:


iorespbitsuop
ppred_busy2:0
": 
:
:


ioreqbitsuop
ppred_busy�functional-unit.scala 268:22�zg
2:0
#:!
:
:


iorespbitsuop	prs3_busy1:/
": 
:
:


ioreqbitsuop	prs3_busy�functional-unit.scala 268:22�zg
2:0
#:!
:
:


iorespbitsuop	prs2_busy1:/
": 
:
:


ioreqbitsuop	prs2_busy�functional-unit.scala 268:22�zg
2:0
#:!
:
:


iorespbitsuop	prs1_busy1:/
": 
:
:


ioreqbitsuop	prs1_busy�functional-unit.scala 268:22�z_
.:,
#:!
:
:


iorespbitsuopppred-:+
": 
:
:


ioreqbitsuopppred�functional-unit.scala 268:22�z]
-:+
#:!
:
:


iorespbitsuopprs3,:*
": 
:
:


ioreqbitsuopprs3�functional-unit.scala 268:22�z]
-:+
#:!
:
:


iorespbitsuopprs2,:*
": 
:
:


ioreqbitsuopprs2�functional-unit.scala 268:22�z]
-:+
#:!
:
:


iorespbitsuopprs1,:*
": 
:
:


ioreqbitsuopprs1�functional-unit.scala 268:22�z]
-:+
#:!
:
:


iorespbitsuoppdst,:*
": 
:
:


ioreqbitsuoppdst�functional-unit.scala 268:22�zc
0:.
#:!
:
:


iorespbitsuoprxq_idx/:-
": 
:
:


ioreqbitsuoprxq_idx�functional-unit.scala 268:22�zc
0:.
#:!
:
:


iorespbitsuopstq_idx/:-
": 
:
:


ioreqbitsuopstq_idx�functional-unit.scala 268:22�zc
0:.
#:!
:
:


iorespbitsuopldq_idx/:-
": 
:
:


ioreqbitsuopldq_idx�functional-unit.scala 268:22�zc
0:.
#:!
:
:


iorespbitsuoprob_idx/:-
": 
:
:


ioreqbitsuoprob_idx�functional-unit.scala 268:22�ze
1:/
#:!
:
:


iorespbitsuopcsr_addr0:.
": 
:
:


ioreqbitsuopcsr_addr�functional-unit.scala 268:22�zi
3:1
#:!
:
:


iorespbitsuop
imm_packed2:0
": 
:
:


ioreqbitsuop
imm_packed�functional-unit.scala 268:22�z_
.:,
#:!
:
:


iorespbitsuoptaken-:+
": 
:
:


ioreqbitsuoptaken�functional-unit.scala 268:22�za
/:-
#:!
:
:


iorespbitsuoppc_lob.:,
": 
:
:


ioreqbitsuoppc_lob�functional-unit.scala 268:22�zg
2:0
#:!
:
:


iorespbitsuop	edge_inst1:/
": 
:
:


ioreqbitsuop	edge_inst�functional-unit.scala 268:22�zc
0:.
#:!
:
:


iorespbitsuopftq_idx/:-
": 
:
:


ioreqbitsuopftq_idx�functional-unit.scala 268:22�za
/:-
#:!
:
:


iorespbitsuopbr_tag.:,
": 
:
:


ioreqbitsuopbr_tag�functional-unit.scala 268:22�zc
0:.
#:!
:
:


iorespbitsuopbr_mask/:-
": 
:
:


ioreqbitsuopbr_mask�functional-unit.scala 268:22�za
/:-
#:!
:
:


iorespbitsuopis_sfb.:,
": 
:
:


ioreqbitsuopis_sfb�functional-unit.scala 268:22�za
/:-
#:!
:
:


iorespbitsuopis_jal.:,
": 
:
:


ioreqbitsuopis_jal�functional-unit.scala 268:22�zc
0:.
#:!
:
:


iorespbitsuopis_jalr/:-
": 
:
:


ioreqbitsuopis_jalr�functional-unit.scala 268:22�z_
.:,
#:!
:
:


iorespbitsuopis_br-:+
": 
:
:


ioreqbitsuopis_br�functional-unit.scala 268:22�zq
7:5
#:!
:
:


iorespbitsuopiw_p2_poisoned6:4
": 
:
:


ioreqbitsuopiw_p2_poisoned�functional-unit.scala 268:22�zq
7:5
#:!
:
:


iorespbitsuopiw_p1_poisoned6:4
": 
:
:


ioreqbitsuopiw_p1_poisoned�functional-unit.scala 268:22�ze
1:/
#:!
:
:


iorespbitsuopiw_state0:.
": 
:
:


ioreqbitsuopiw_state�functional-unit.scala 268:22�zu
9:7
-:+
#:!
:
:


iorespbitsuopctrlis_std8:6
,:*
": 
:
:


ioreqbitsuopctrlis_std�functional-unit.scala 268:22�zu
9:7
-:+
#:!
:
:


iorespbitsuopctrlis_sta8:6
,:*
": 
:
:


ioreqbitsuopctrlis_sta�functional-unit.scala 268:22�zw
::8
-:+
#:!
:
:


iorespbitsuopctrlis_load9:7
,:*
": 
:
:


ioreqbitsuopctrlis_load�functional-unit.scala 268:22�zw
::8
-:+
#:!
:
:


iorespbitsuopctrlcsr_cmd9:7
,:*
": 
:
:


ioreqbitsuopctrlcsr_cmd�functional-unit.scala 268:22�zu
9:7
-:+
#:!
:
:


iorespbitsuopctrlfcn_dw8:6
,:*
": 
:
:


ioreqbitsuopctrlfcn_dw�functional-unit.scala 268:22�zu
9:7
-:+
#:!
:
:


iorespbitsuopctrlop_fcn8:6
,:*
": 
:
:


ioreqbitsuopctrlop_fcn�functional-unit.scala 268:22�zw
::8
-:+
#:!
:
:


iorespbitsuopctrlimm_sel9:7
,:*
": 
:
:


ioreqbitsuopctrlimm_sel�functional-unit.scala 268:22�zw
::8
-:+
#:!
:
:


iorespbitsuopctrlop2_sel9:7
,:*
": 
:
:


ioreqbitsuopctrlop2_sel�functional-unit.scala 268:22�zw
::8
-:+
#:!
:
:


iorespbitsuopctrlop1_sel9:7
,:*
": 
:
:


ioreqbitsuopctrlop1_sel�functional-unit.scala 268:22�zw
::8
-:+
#:!
:
:


iorespbitsuopctrlbr_type9:7
,:*
": 
:
:


ioreqbitsuopctrlbr_type�functional-unit.scala 268:22�zc
0:.
#:!
:
:


iorespbitsuopfu_code/:-
": 
:
:


ioreqbitsuopfu_code�functional-unit.scala 268:22�zc
0:.
#:!
:
:


iorespbitsuopiq_type/:-
": 
:
:


ioreqbitsuopiq_type�functional-unit.scala 268:22�ze
1:/
#:!
:
:


iorespbitsuopdebug_pc0:.
": 
:
:


ioreqbitsuopdebug_pc�functional-unit.scala 268:22�za
/:-
#:!
:
:


iorespbitsuopis_rvc.:,
": 
:
:


ioreqbitsuopis_rvc�functional-unit.scala 268:22�zi
3:1
#:!
:
:


iorespbitsuop
debug_inst2:0
": 
:
:


ioreqbitsuop
debug_inst�functional-unit.scala 268:22�z]
-:+
#:!
:
:


iorespbitsuopinst,:*
": 
:
:


ioreqbitsuopinst�functional-unit.scala 268:22�z]
-:+
#:!
:
:


iorespbitsuopuopc,:*
": 
:
:


ioreqbitsuopuopc�functional-unit.scala 268:22S2<
_T_44R2.:,
:
:


iobrupdateb1resolve_mask�util.scala 85:27^2G
_T_5?R=/:-
": 
:
:


ioreqbitsuopbr_mask

_T_4�util.scala 85:25_z<
0:.
#:!
:
:


iorespbitsuopbr_mask

_T_5�functional-unit.scala 269:30X25
_T_6-R+':%
:
:


ioreqbitsrs1_data�functional-unit.scala 484:35n2K
_T_7CRA2:0
": 
:
:


ioreqbitsuop
imm_packed
19
8�functional-unit.scala 484:7092
_T_8R

_T_7�functional-unit.scala 484:77C2 
_T_9R

_T_6

_T_8�functional-unit.scala 484:42?2
_T_10R

_T_9
1�functional-unit.scala 484:42;2
_T_11R	

_T_10�functional-unit.scala 484:4292
sumR	

_T_11�functional-unit.scala 484:85E2"
_T_12R

sum
38
38�functional-unit.scala 485:24E2"
_T_13R

sum
63
39�functional-unit.scala 485:43;2
_T_14R	

_T_13�functional-unit.scala 485:39H2%
_T_15R	

_T_14	

0�functional-unit.scala 485:58E2"
_T_16R

sum
63
39�functional-unit.scala 486:43H2%
_T_17R	

_T_16	

0�functional-unit.scala 486:58Q2.
ea_sign#2!
	

_T_12	

_T_15	

_T_17�functional-unit.scala 485:20D2!
_T_18R

sum
38
0�functional-unit.scala 487:43G21
effective_addressR
	
ea_sign	

_T_18�Cat.scala 29:58`z=
$:"
:
:


iorespbitsaddr

effective_address�functional-unit.scala 491:21rzO
$:"
:
:


iorespbitsdata':%
:
:


ioreqbitsrs2_data�functional-unit.scala 492:21�2c
_T_19ZRX:
:


ioreqvalid8:6
,:*
": 
:
:


ioreqbitsuopctrlis_std�functional-unit.scala 495:28b2?
_T_206R4$:"
:
:


iorespbitsdata
64
64�functional-unit.scala 496:24E2"
_T_21R	

_T_20
0
0�functional-unit.scala 496:29H2%
_T_22R	

_T_21	

1�functional-unit.scala 496:36F2#
_T_23R	

_T_19	

_T_22�functional-unit.scala 495:59H2%
_T_24R	

_T_23	

0�functional-unit.scala 495:13E2"
_T_25R	

reset
0
0�functional-unit.scala 495:12F2#
_T_26R	

_T_24	

_T_25�functional-unit.scala 495:12H2%
_T_27R	

_T_26	

0�functional-unit.scala 495:12�:�
	

_T_27�R�
�Assertion failed: 65th bit set in MemAddrCalcUnit.
    at functional-unit.scala:495 assert (!(io.req.valid && io.req.bits.uop.ctrl.is_std &&
	

clock"	

1�functional-unit.scala 495:12=B	

clock	

1�functional-unit.scala 495:12�functional-unit.scala 495:12�2c
_T_28ZRX:
:


ioreqvalid8:6
,:*
": 
:
:


ioreqbitsuopctrlis_std�functional-unit.scala 498:28k2H
_T_29?R=	

_T_28.:,
": 
:
:


ioreqbitsuopfp_val�functional-unit.scala 498:59H2%
_T_30R	

_T_29	

0�functional-unit.scala 498:13E2"
_T_31R	

reset
0
0�functional-unit.scala 498:12F2#
_T_32R	

_T_30	

_T_31�functional-unit.scala 498:12H2%
_T_33R	

_T_32	

0�functional-unit.scala 498:12�:�
	

_T_33�R�
�Assertion failed: FP store-data should now be going through a different unit.
    at functional-unit.scala:498 assert (!(io.req.valid && io.req.bits.uop.ctrl.is_std && io.req.bits.uop.fp_val),
	

clock"	

1�functional-unit.scala 498:12=B	

clock	

1�functional-unit.scala 498:12�functional-unit.scala 498:12|2Y
_T_34PRN.:,
": 
:
:


ioreqbitsuopfp_val:
:


ioreqvalid�functional-unit.scala 502:36k2H
_T_35?R=,:*
": 
:
:


ioreqbitsuopuopc	

1�functional-unit.scala 502:76F2#
_T_36R	

_T_34	

_T_35�functional-unit.scala 502:52k2H
_T_37?R=,:*
": 
:
:


ioreqbitsuopuopc	

2�functional-unit.scala 503:41F2#
_T_38R	

_T_36	

_T_37�functional-unit.scala 503:17H2%
_T_39R	

_T_38	

0�functional-unit.scala 502:11E2"
_T_40R	

reset
0
0�functional-unit.scala 502:10F2#
_T_41R	

_T_39	

_T_40�functional-unit.scala 502:10H2%
_T_42R	

_T_41	

0�functional-unit.scala 502:10�:�
	

_T_42�R�
�Assertion failed: [maddrcalc] assert we never get store data in here.
    at functional-unit.scala:502 assert (!(io.req.bits.uop.fp_val && io.req.valid && io.req.bits.uop.uopc =/=
	

clock"	

1�functional-unit.scala 502:10=B	

clock	

1�functional-unit.scala 502:10�functional-unit.scala 502:10o2L
_T_43CRA0:.
": 
:
:


ioreqbitsuopmem_size	

1�functional-unit.scala 509:11Q2.
_T_44%R#

effective_address
0
0�functional-unit.scala 509:40H2%
_T_45R	

_T_44	

0�functional-unit.scala 509:44F2#
_T_46R	

_T_43	

_T_45�functional-unit.scala 509:19o2L
_T_47CRA0:.
": 
:
:


ioreqbitsuopmem_size	

2�functional-unit.scala 510:11Q2.
_T_48%R#

effective_address
1
0�functional-unit.scala 510:40H2%
_T_49R	

_T_48	

0�functional-unit.scala 510:46F2#
_T_50R	

_T_47	

_T_49�functional-unit.scala 510:19F2#
_T_51R	

_T_46	

_T_50�functional-unit.scala 509:54o2L
_T_52CRA0:.
": 
:
:


ioreqbitsuopmem_size	

3�functional-unit.scala 511:11Q2.
_T_53%R#

effective_address
2
0�functional-unit.scala 511:40H2%
_T_54R	

_T_53	

0�functional-unit.scala 511:46F2#
_T_55R	

_T_52	

_T_54�functional-unit.scala 511:19K2(

misalignedR	

_T_51	

_T_55�functional-unit.scala 510:56<*
bkptuBreakpointUnit_4�functional-unit.scala 513:21(z!
:
	

bkptuclock	

clock�
 (z!
:
	

bkptureset	

reset�
 hzE
&:$
:
:
	

bkptuiostatusuie:
:


iostatusuie�functional-unit.scala 514:19hzE
&:$
:
:
	

bkptuiostatussie:
:


iostatussie�functional-unit.scala 514:19hzE
&:$
:
:
	

bkptuiostatushie:
:


iostatushie�functional-unit.scala 514:19hzE
&:$
:
:
	

bkptuiostatusmie:
:


iostatusmie�functional-unit.scala 514:19jzG
':%
:
:
	

bkptuiostatusupie:
:


iostatusupie�functional-unit.scala 514:19jzG
':%
:
:
	

bkptuiostatusspie:
:


iostatusspie�functional-unit.scala 514:19jzG
':%
:
:
	

bkptuiostatushpie:
:


iostatushpie�functional-unit.scala 514:19jzG
':%
:
:
	

bkptuiostatusmpie:
:


iostatusmpie�functional-unit.scala 514:19hzE
&:$
:
:
	

bkptuiostatusspp:
:


iostatusspp�functional-unit.scala 514:19fzC
%:#
:
:
	

bkptuiostatusvs:
:


iostatusvs�functional-unit.scala 514:19hzE
&:$
:
:
	

bkptuiostatusmpp:
:


iostatusmpp�functional-unit.scala 514:19fzC
%:#
:
:
	

bkptuiostatusfs:
:


iostatusfs�functional-unit.scala 514:19fzC
%:#
:
:
	

bkptuiostatusxs:
:


iostatusxs�functional-unit.scala 514:19jzG
':%
:
:
	

bkptuiostatusmprv:
:


iostatusmprv�functional-unit.scala 514:19hzE
&:$
:
:
	

bkptuiostatussum:
:


iostatussum�functional-unit.scala 514:19hzE
&:$
:
:
	

bkptuiostatusmxr:
:


iostatusmxr�functional-unit.scala 514:19hzE
&:$
:
:
	

bkptuiostatustvm:
:


iostatustvm�functional-unit.scala 514:19fzC
%:#
:
:
	

bkptuiostatustw:
:


iostatustw�functional-unit.scala 514:19hzE
&:$
:
:
	

bkptuiostatustsr:
:


iostatustsr�functional-unit.scala 514:19lzI
(:&
:
:
	

bkptuiostatuszero1:
:


iostatuszero1�functional-unit.scala 514:19pzM
*:(
:
:
	

bkptuiostatussd_rv32:
:


iostatussd_rv32�functional-unit.scala 514:19hzE
&:$
:
:
	

bkptuiostatusuxl:
:


iostatusuxl�functional-unit.scala 514:19hzE
&:$
:
:
	

bkptuiostatussxl:
:


iostatussxl�functional-unit.scala 514:19lzI
(:&
:
:
	

bkptuiostatuszero2:
:


iostatuszero2�functional-unit.scala 514:19fzC
%:#
:
:
	

bkptuiostatussd:
:


iostatussd�functional-unit.scala 514:19hzE
&:$
:
:
	

bkptuiostatusprv:
:


iostatusprv�functional-unit.scala 514:19jzG
':%
:
:
	

bkptuiostatusdprv:
:


iostatusdprv�functional-unit.scala 514:19hzE
&:$
:
:
	

bkptuiostatusisa:
:


iostatusisa�functional-unit.scala 514:19hzE
&:$
:
:
	

bkptuiostatuswfi:
:


iostatuswfi�functional-unit.scala 514:19lzI
(:&
:
:
	

bkptuiostatuscease:
:


iostatuscease�functional-unit.scala 514:19lzI
(:&
:
:
	

bkptuiostatusdebug:
:


iostatusdebug�functional-unit.scala 514:19?�
:
:
	

bkptuiopc�functional-unit.scala 516:19Uz2
:
:
	

bkptuioea

effective_address�functional-unit.scala 517:19k2H
_T_56?R=,:*
": 
:
:


ioreqbitsuopuopc	

1�functional-unit.scala 519:53W24
_T_57+R):
:


ioreqvalid	

_T_56�functional-unit.scala 519:29K2(
ma_ldR	

_T_57


misaligned�functional-unit.scala 519:63k2H
_T_58?R=,:*
": 
:
:


ioreqbitsuopuopc	

2�functional-unit.scala 520:54l2I
_T_59@R>,:*
": 
:
:


ioreqbitsuopuopc


67�functional-unit.scala 520:89F2#
_T_60R	

_T_58	

_T_59�functional-unit.scala 520:65W24
_T_61+R):
:


ioreqvalid	

_T_60�functional-unit.scala 520:29L2(
ma_stR	

_T_61


misaligned�functional-unit.scala 520:104k2H
_T_62?R=,:*
": 
:
:


ioreqbitsuopuopc	

1�functional-unit.scala 521:55\29
_T_630R.	

_T_62:
:
	

bkptuiodebug_ld�functional-unit.scala 521:66k2H
_T_64?R=,:*
": 
:
:


ioreqbitsuopuopc	

2�functional-unit.scala 522:55\29
_T_650R.	

_T_64:
:
	

bkptuiodebug_st�functional-unit.scala 522:66F2#
_T_66R	

_T_63	

_T_65�functional-unit.scala 521:88X25
dbg_bp+R):
:


ioreqvalid	

_T_66�functional-unit.scala 521:29k2H
_T_67?R=,:*
": 
:
:


ioreqbitsuopuopc	

1�functional-unit.scala 523:55[28
_T_68/R-	

_T_67:
:
	

bkptuioxcpt_ld�functional-unit.scala 523:66k2H
_T_69?R=,:*
": 
:
:


ioreqbitsuopuopc	

2�functional-unit.scala 524:55[28
_T_70/R-	

_T_69:
:
	

bkptuioxcpt_st�functional-unit.scala 524:66F2#
_T_71R	

_T_68	

_T_70�functional-unit.scala 523:87T21
bp+R):
:


ioreqvalid	

_T_71�functional-unit.scala 523:29F2#
_T_72R	

ma_ld	

ma_st�functional-unit.scala 527:26G2$
_T_73R	

_T_72


dbg_bp�functional-unit.scala 527:26F2#
xcpt_valR	

_T_73

bp�functional-unit.scala 527:26H22
_T_74)2'



dbg_bp


14	

3�Mux.scala 47:69D2.
_T_75%2#
	

ma_st	

6	

_T_74�Mux.scala 47:69I23

xcpt_cause%2#
	

ma_ld	

4	

_T_75�Mux.scala 47:69cz@
0:.
%:#
:
:


iorespbitsmxcptvalid


xcpt_val�functional-unit.scala 534:28dzA
/:-
%:#
:
:


iorespbitsmxcptbits


xcpt_cause�functional-unit.scala 535:28F2#
_T_76R	

ma_ld	

ma_st�functional-unit.scala 536:19H2%
_T_77R	

_T_76	

0�functional-unit.scala 536:11E2"
_T_78R	

reset
0
0�functional-unit.scala 536:10F2#
_T_79R	

_T_77	

_T_78�functional-unit.scala 536:10H2%
_T_80R	

_T_79	

0�functional-unit.scala 536:10�:�
	

_T_80�R�
�Assertion failed: Mutually-exclusive exceptions are firing.
    at functional-unit.scala:536 assert (!(ma_ld && ma_st), "Mutually-exclusive exceptions are firing.")
	

clock"	

1�functional-unit.scala 536:10=B	

clock	

1�functional-unit.scala 536:10�functional-unit.scala 536:10o2L
_T_81CRA/:-
": 
:
:


ioreqbitsuopmem_cmd


20�functional-unit.scala 538:72W24
_T_82+R):
:


ioreqvalid	

_T_81�functional-unit.scala 538:45az>
1:/
&:$
:
:


iorespbitssfencevalid	

_T_82�functional-unit.scala 538:29l2I
_T_83@R>0:.
": 
:
:


ioreqbitsuopmem_size
0
0�functional-unit.scala 539:59izF
9:7
0:.
&:$
:
:


iorespbitssfencebitsrs1	

_T_83�functional-unit.scala 539:32l2I
_T_84@R>0:.
": 
:
:


ioreqbitsuopmem_size
1
1�functional-unit.scala 540:59izF
9:7
0:.
&:$
:
:


iorespbitssfencebitsrs2	

_T_84�functional-unit.scala 540:32�ze
::8
0:.
&:$
:
:


iorespbitssfencebitsaddr':%
:
:


ioreqbitsrs1_data�functional-unit.scala 541:33�ze
::8
0:.
&:$
:
:


iorespbitssfencebitsasid':%
:
:


ioreqbitsrs2_data�functional-unit.scala 542:33
MemAddrCalcUnit