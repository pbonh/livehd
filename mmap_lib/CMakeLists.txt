# ---- Create standalone library ----
file(GLOB mmap_lib_headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp")

add_library(LiveHDMMapLib ${mmap_lib_headers})
set_target_properties(LiveHDMMapLib PROPERTIES CXX_STANDARD 17 OUTPUT_NAME "LiveHDMMapLib" LINKER_LANGUAGE CXX)

#add_subdirectory(tests)

