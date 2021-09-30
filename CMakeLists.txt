cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

# ---- Project ----

# Note: update this to your new project's name and version
project(
  LiveHD
  VERSION 1.0
  LANGUAGES CXX
)

# ---- Include guards ----

if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(
    FATAL_ERROR
      "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there."
  )
endif()

# ---- Imported Definitions from Bazel ----
add_definitions(
    -DSIZEOF_VOID_P=8
    -D_DEFAULT_SOURCE
    -DBTOR_USE_CMS=1
    -DRL_LIBRARY_VERSION='"7.0"'
    -DHAVE_CONFIG_H
    -DABCEXTERNAL=\"abc\"
    -D_YOSYS_
    -DABC_USE_CUDD=1
    -D_GNU_SOURCE
    -DSIZEOF_LONG=8
    -Dcryptominisat5_EXPORTS
    -DGTEST_HAS_ABSL=1
    -DYOSYS_ENABLE_READLINE
    -DFMT_HEADER_ONLY
    -DLIN64
    -DNOMINMAX
    -DABC_USE_PTHREADS
    -DABC_USE_READLINE
    -DBOOST_FALLTHROUGH
    -DNDEBUG
    -DBOOST_ALL_NO_LIB
    -DTRACE
    -DREADLINE_HAVE_CONFIG_H
    -DSIZEOF_INT=4
    -DUSE_GAUSS
    -DYOSYS_ENABLE_COVER)
#-DYOSYS_SRC='"./"'
#-DYOSYS_DATDIR='std::getenv("YOSYS_DATDIR") ? std::getenv("YOSYS_DATDIR") : "."'
#-DYOSYS_ENABLE_ABC
#-DYOSYS_ENABLE_GLOB

# ---- Add dependencies via CPM ----
# see https://github.com/TheLartians/CPM.cmake for more info

include(cmake/CPM.cmake)

# PackageProject.cmake will be used to make our target installable
#CPMAddPackage("gh:TheLartians/PackageProject.cmake@1.6.0")

#find_package(Boost 1.77.0 COMPONENTS multiprecision container graph)
#FIND_PACKAGE(Boost 1.71 COMPONENTS graph REQUIRED)
set(BOOST_INCLUDEDIR /usr/include)
find_package(Boost REQUIRED)
include_directories(${Boost_INCLUDE_DIRS})
include(FetchContent)
FetchContent_Declare(
    absl
    GIT_REPOSITORY https://github.com/abseil/abseil-cpp.git
    GIT_TAG        20210324.2
    )
FetchContent_MakeAvailable(absl)
include_directories(${absl_SOURCE_DIR})
FetchContent_Declare(
    fmt
    GIT_REPOSITORY https://github.com/fmtlib/fmt.git
    GIT_TAG        8.0.1
    )
FetchContent_MakeAvailable(fmt)
include_directories(${fmt_SOURCE_DIR}/include)
FetchContent_Declare(
    iassert
    GIT_REPOSITORY https://github.com/masc-ucsc/iassert.git
    )
FetchContent_MakeAvailable(iassert)
include_directories(${iassert_SOURCE_DIR}/src)
FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG        release-1.11.0
)
FetchContent_MakeAvailable(googletest)
include_directories(${googletest_SOURCE_DIR}/googletest/include)
FetchContent_Declare(
  rapidjson
  GIT_REPOSITORY https://github.com/Tencent/rapidjson.git
  GIT_TAG        v1.1.0
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
)
FetchContent_GetProperties(rapidjson)
if(NOT rapidjson_POPULATED)
  FetchContent_Populate(rapidjson)
endif()
include_directories(${rapidjson_SOURCE_DIR}/include)

#include_directories(${CMAKE_CURRENT_SOURCE_DIR}/mmap_lib/include)
#include_directories(${CMAKE_CURRENT_SOURCE_DIR}/task)
#include_directories(${CMAKE_CURRENT_SOURCE_DIR}/simlib)
#include_directories(${CMAKE_CURRENT_SOURCE_DIR}/lemu)
#include_directories(${CMAKE_CURRENT_SOURCE_DIR}/elab)

# ---- Add source files ----

# Note: globbing sources is considered bad practice as CMake's generators may not detect new files
# automatically. Keep that in mind when changing files, or explicitly mention them here.
#file(GLOB_RECURSE third_party_lef_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/third_party/misc/lef/lef/*.h*")
#file(GLOB_RECURSE third_party_lef_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/third_party/misc/lef/lef/*.cpp")
#file(GLOB_RECURSE third_party_ezsat_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/third_party/misc/ezsat/*.h*")
#file(GLOB_RECURSE third_party_ezsat_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/third_party/misc/ezsat/*.cpp")
#file(GLOB_RECURSE third_party_def_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/third_party/misc/def/def/*.h*")
#file(GLOB_RECURSE third_party_def_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/third_party/misc/def/def/*.cpp")
#file(GLOB_RECURSE third_party_archfp_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/third_party/misc/ArchFP/*.h*")
#file(GLOB_RECURSE third_party_archfp_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/third_party/misc/ArchFP/*.cpp")
#file(GLOB_RECURSE simlib_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/simlib/*.h*")
#file(GLOB_RECURSE simlib_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/simlib/*.cpp")
#file(GLOB_RECURSE pass_submatch_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/pass/submatch/*.h*")
#file(GLOB_RECURSE pass_submatch_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/pass/submatch/*.cpp")
#file(GLOB_RECURSE pass_semantic_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/pass/semantic/*.h*")
#file(GLOB_RECURSE pass_semantic_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/pass/semantic/*.cpp")
#file(GLOB_RECURSE pass_sat_opt_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/pass/sat_opt/*.h*")
#file(GLOB_RECURSE pass_sat_opt_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/pass/sat_opt/*.cpp")
#file(GLOB_RECURSE pass_punch_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/pass/punch/*.h*")
#file(GLOB_RECURSE pass_punch_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/pass/punch/*.cpp")
#file(GLOB_RECURSE pass_lnastopt_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/pass/lnastopt/*.h*")
#file(GLOB_RECURSE pass_lnastopt_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/pass/lnastopt/*.cpp")
#file(GLOB_RECURSE pass_lnastfmt_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/pass/lnastfmt/*.h*")
#file(GLOB_RECURSE pass_lnastfmt_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/pass/lnastfmt/*.cpp")
#file(GLOB_RECURSE headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/include/*.h")
#file(GLOB_RECURSE sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/source/*.cpp")
add_subdirectory(mmap_lib)
add_subdirectory(task)
add_subdirectory(simlib)
add_subdirectory(lemu)
add_subdirectory(elab)
add_subdirectory(core)

# ---- Create library ----

# Note: for header-only libraries change all PUBLIC flags to INTERFACE and create an interface
# target: add_library(LiveHD INTERFACE)
#add_library(LiveHD ${headers} ${sources})

#set_target_properties(LiveHD PROPERTIES CXX_STANDARD 17)

# being a cross-platform target, we enforce standards conformance on MSVC
#target_compile_options(LiveHD PUBLIC "$<$<COMPILE_LANG_AND_ID:CXX,MSVC>:/permissive->")

# Link dependencies
#target_link_libraries(LiveHD PRIVATE absl)

#target_include_directories(
#    LiveHD PUBLIC $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
#                 $<INSTALL_INTERFACE:include/${PROJECT_NAME}-${PROJECT_VERSION}>
#)

# ---- Create an installable target ----
# this allows users to install and find the library via `find_package()`.

# the location where the project's version header will be placed should match the project's regular
# header paths
string(TOLOWER ${PROJECT_NAME}/version.h VERSION_HEADER_LOCATION)

#packageProject(
#  NAME ${PROJECT_NAME}
#  VERSION ${PROJECT_VERSION}
#  NAMESPACE ${PROJECT_NAME}
#  BINARY_DIR ${PROJECT_BINARY_DIR}
#  INCLUDE_DIR ${PROJECT_SOURCE_DIR}/include
#  INCLUDE_DESTINATION include/${PROJECT_NAME}-${PROJECT_VERSION}
#  VERSION_HEADER "${VERSION_HEADER_LOCATION}"
#  COMPATIBILITY SameMajorVersion
#  DEPENDENCIES "fmt 7.1.3"
#)
