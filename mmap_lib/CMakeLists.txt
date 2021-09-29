cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(LiveHDMMapLib LANGUAGES CXX)

# --- Import tools ----

include(../cmake/tools.cmake)

# ---- Dependencies ----

include(../cmake/CPM.cmake)

CPMAddPackage(
  NAME absl
  GIT_TAG 20210324.2
  GITHUB_REPOSITORY abseil/abseil-cpp
  OPTIONS "GTEST_HAS_ABSL 1"
)

#CPMAddPackage(NAME LiveHDMMapLib SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/..)

# ---- Create standalone library ----

file(GLOB_RECURSE mmap_lib_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp")

add_library(LiveHDMMapLib ${mmap_lib_headers})

set_target_properties(LiveHDMMapLib PROPERTIES CXX_STANDARD 17 OUTPUT_NAME "LiveHDMMapLib" LINKER_LANGUAGE CXX)

target_link_libraries(LiveHDMMapLib absl)
