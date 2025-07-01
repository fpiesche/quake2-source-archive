cmake_minimum_required(VERSION 3.10)
set(MOD_NAME "napalm")
project(${MOD_NAME} C)

file(GLOB MOD_SRC
  "sources/${MOD_NAME}/firemod/*.c"
  "sources/${MOD_NAME}/firemod/*.h"
  "sources/${MOD_NAME}/firepure/*.c"
  "sources/${MOD_NAME}/firepure/*.h"
)

add_library(${MOD_NAME} SHARED ${MOD_SRC})
set_target_properties(${MOD_NAME} PROPERTIES PREFIX "")
set_target_properties(${MOD_NAME} PROPERTIES OUTPUT_NAME "bin/${MOD_NAME}/${OS_HANDLE}/game${Q2_BUILD_ARCH}")
