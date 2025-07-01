cmake_minimum_required(VERSION 3.10)
set(MOD_NAME "spaq")
project(${MOD_NAME} C)

file(GLOB MOD_SRC
  "sources/${MOD_NAME}/src/source/*.c"
  "sources/${MOD_NAME}/src/source/*.h"
  "sources/${MOD_NAME}/src/source/addons/tngbot/*.c"
)

add_library(${MOD_NAME} SHARED ${MOD_SRC})
set_target_properties(${MOD_NAME} PROPERTIES PREFIX "")
set_target_properties(${MOD_NAME} PROPERTIES OUTPUT_NAME "${CMAKE_BINARY_DIR}/${MOD_NAME}/${OS_HANDLE}/game${Q2_BUILD_ARCH}")
