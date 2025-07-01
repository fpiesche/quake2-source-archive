cmake_minimum_required(VERSION 3.10)
set(MOD_NAME "coopordie")
project(${MOD_NAME} C)

file(GLOB MOD_SRC
  "sources/${MOD_NAME}/game/trunk/code/game/*.c"
  "sources/${MOD_NAME}/game/trunk/code/game/*.h"
  "sources/${MOD_NAME}/game/trunk/code/game/wsrv/*.c"
  "sources/${MOD_NAME}/game/trunk/code/game/wsrv/*.h"
)

add_library(${MOD_NAME} SHARED ${MOD_SRC})
set_target_properties(${MOD_NAME} PROPERTIES PREFIX "")
set_target_properties(${MOD_NAME} PROPERTIES OUTPUT_NAME "${CMAKE_BINARY_DIR}/${MOD_NAME}/${OS_HANDLE}/game${Q2_BUILD_ARCH}")
target_include_directories(${MOD_NAME} PRIVATE "sources/${MOD_NAME}/game" "sources/${MOD_NAME}/game/wsrv")
