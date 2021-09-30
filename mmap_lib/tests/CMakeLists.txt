# ---- Create standalone library ----
file(GLOB mmap_lib_test_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp")
file(GLOB mmap_lib_test_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")

include_directories(
    ${PROJECT_SOURCE_DIR}/task
    ${PROJECT_SOURCE_DIR}/mmap_lib/include
    ${googletest_SOURCE_DIR}/googletest/include
    ${googletest_SOURCE_DIR}/googlemock/include
    ${PROJECT_SOURCE_DIR}/mmap_lib/tests
)

enable_testing()

add_executable(LiveHDMMapLibGCTest mmap_gc_test.cpp)
set_target_properties(LiveHDMMapLibGCTest PROPERTIES CXX_STANDARD 17 OUTPUT_NAME "LiveHDMMapLibGCTest")
target_link_libraries(LiveHDMMapLibGCTest LiveHDMMapLib gtest gtest_main absl::base absl::strings absl::synchronization absl::hash absl::raw_hash_map)

add_executable(LiveHDMMapLibMapTest mmap_map_test.cpp)
set_target_properties(LiveHDMMapLibMapTest PROPERTIES CXX_STANDARD 17 OUTPUT_NAME "LiveHDMMapLibMapTest")
target_link_libraries(LiveHDMMapLibMapTest LiveHDMMapLib gtest gtest_main absl::base absl::strings absl::synchronization absl::hash absl::raw_hash_map)

include(GoogleTest)
gtest_discover_tests(LiveHDMMapLibGCTest)
gtest_discover_tests(LiveHDMMapLibMapTest)
