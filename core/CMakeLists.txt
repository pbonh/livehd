# ---- Create standalone library ----
file(GLOB core_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp")
file(GLOB core_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")

include_directories(
    ${PROJECT_SOURCE_DIR}/elab
    ${PROJECT_SOURCE_DIR}/core
)

add_library(LiveHDCore ${core_sources})

set_target_properties(LiveHDCore PROPERTIES CXX_STANDARD 17 OUTPUT_NAME "LiveHDCore LGraph")

target_link_libraries(LiveHDCore LiveHDElab LiveHDMMapLib LiveHDTask LiveHDLemu fmt)
