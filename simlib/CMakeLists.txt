# ---- Create standalone library ----
file(GLOB simlib_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp")
file(GLOB simlib_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")

add_library(LiveHDSimLib ${simlib_headers} ${simlib_sources})

set_target_properties(LiveHDSimLib PROPERTIES CXX_STANDARD 17 OUTPUT_NAME "LiveHDSimLib")
target_link_libraries(LiveHDSimLib LiveHDMMapLib LiveHDTask)
target_include_directories(
    LiveHDSimLib PUBLIC $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/task>
                      $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/mmap_lib/include>
                      $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/simlib>
)
