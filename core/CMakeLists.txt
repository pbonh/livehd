cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(LiveHDCore LANGUAGES CXX)

# --- Import tools ----

include(../cmake/tools.cmake)

# ---- Dependencies ----

include(../cmake/CPM.cmake)

#CPMAddPackage(
#  NAME absl
#  GIT_TAG 20210324.2
#  GITHUB_REPOSITORY abseil/abseil-cpp
#  OPTIONS "GTEST_HAS_ABSL 1"
#)

#CPMAddPackage(NAME LiveHDCore SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/..)

# ---- Create standalone library ----

file(GLOB_RECURSE core_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp")
file(GLOB_RECURSE core_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")

add_library(LiveHDCore ${core_headers} ${core_sources})

set_target_properties(LiveHDCore PROPERTIES CXX_STANDARD 17 OUTPUT_NAME "LiveHDCore LGraph")

#target_link_libraries(LiveHDCore LiveHDElab LiveHDMMapLib LiveHDTask)
#target_link_libraries(LiveHDCore ${Boost_LIBRARIES})
