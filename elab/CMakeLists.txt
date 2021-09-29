cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(LiveHDElab LANGUAGES CXX)

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

#CPMAddPackage(NAME LiveHDElab SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/..)

# ---- Create standalone library ----

file(GLOB_RECURSE elab_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp")
file(GLOB_RECURSE elab_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")
#file(GLOB_RECURSE elab_test_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/test/*.cpp")

add_library(LiveHDElab ${elab_headers} ${elab_sources})
set_target_properties(LiveHDElab PROPERTIES CXX_STANDARD 17 OUTPUT_NAME "LiveHDElab")

target_include_directories(
    LiveHDElab PUBLIC $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
)
#                $<INSTALL_INTERFACE:include/${PROJECT_NAME}-${PROJECT_VERSION}>
target_link_libraries(LiveHDElab absl)
