cmake_minimum_required(VERSION 3.7)
project(q2mods)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

file(GLOB MODS LIST_DIRECTORIES true "sources/*")
foreach(item ${MODS})
	if(IS_DIRECTORY ${item})
    cmake_path(GET item FILENAME mod)
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/cmake/mods/${mod}.cmake")
      message(STATUS "Adding mod: cmake/mods/${mod}.cmake")
      include(mods/${mod})
    else()
      set(MOD_SRC "")
      file(GLOB MOD_SRC
        "${CMAKE_CURRENT_SOURCE_DIR}/sources/${mod}/*.c"
        "${CMAKE_CURRENT_SOURCE_DIR}/sources/${mod}/*.h"
      )
      if(NOT MOD_SRC)
        message(WARNING "No source files found for ${mod}")
      else()
        message("-- Adding mod: ${mod}")
        add_library(${mod} SHARED ${MOD_SRC})
        set_target_properties(${mod} PROPERTIES PREFIX "")
        set_target_properties(${mod} PROPERTIES OUTPUT_NAME "bin/${mod}/game${CMAKE_SYSTEM_PROCESSOR}")
      endif()
    endif()
  endif()
endforeach()
