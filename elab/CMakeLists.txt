# ---- Create standalone library ----
file(GLOB elab_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp")
file(GLOB elab_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")
#file(GLOB_RECURSE elab_test_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/test/*.cpp")

add_library(LiveHDElab ${elab_headers} ${elab_sources})
set_target_properties(LiveHDElab PROPERTIES CXX_STANDARD 17 OUTPUT_NAME "LiveHDElab")

target_include_directories(
    LiveHDElab PUBLIC $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
)
#                $<INSTALL_INTERFACE:include/${PROJECT_NAME}-${PROJECT_VERSION}>
target_link_libraries(LiveHDElab LiveHDMMapLib LiveHDLemu LiveHDTask)
