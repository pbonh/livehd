cmake_minimum_required(VERSION 3.14)
project(
  LiveHD
  VERSION 0.0.1
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
    -DGTEST_HAS_ABSL=0
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

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    # ---- Add boost dependency ----
    set(BOOST_INCLUDEDIR /usr/include)
    find_package(Boost REQUIRED)
    include_directories(${Boost_INCLUDE_DIRS})

    # ---- Add dependencies via FetchContent ----
    include(FetchContent)

    set(ABSL_CXX_STANDARD 11)
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
      GIT_TAG        master
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
endif()

# ---- Add project files ----
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
