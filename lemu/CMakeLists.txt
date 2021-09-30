# ---- Create standalone library ----
file(GLOB lemu_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp")
file(GLOB lemu_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")

add_library(LiveHDLemu ${lemu_headers} ${lemu_sources})

set_target_properties(LiveHDLemu PROPERTIES CXX_STANDARD 17 OUTPUT_NAME "LiveHDLemu")
target_link_libraries(LiveHDLemu LiveHDMMapLib LiveHDTask LiveHDSimLib)
target_include_directories(
    LiveHDLemu PUBLIC $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/task>
                      $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/mmap_lib/include>
                      $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/simlib>
                      $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/lemu>
)
