# ---- Create standalone library ----
file(GLOB task_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp")
file(GLOB task_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")

add_library(LiveHDTask ${task_headers} ${task_sources})

set_target_properties(LiveHDTask PROPERTIES CXX_STANDARD 17 OUTPUT_NAME "LiveHDTask")
target_link_libraries(LiveHDTask LiveHDMMapLib)
target_include_directories(
    LiveHDTask PUBLIC $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/mmap_lib/include>
                      $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/task>
)
