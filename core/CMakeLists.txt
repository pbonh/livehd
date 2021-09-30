# ---- Create standalone library ----
file(GLOB core_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp")
file(GLOB core_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")

add_library(LiveHDCore ${core_headers} ${core_sources})

set_target_properties(LiveHDCore PROPERTIES CXX_STANDARD 17 OUTPUT_NAME "LiveHDCore LGraph")

target_link_libraries(LiveHDCore LiveHDElab LiveHDMMapLib LiveHDTask LiveHDLemu)
target_include_directories(
    LiveHDLemu PUBLIC $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/elab>
                      $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/core>
)
#target_link_libraries(LiveHDCore ${Boost_LIBRARIES})
