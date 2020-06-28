cmake_minimum_required(VERSION 3.14.0)
project(patchmatch_crosscompiling)

# Define common path for installing libraries to
# LIBRARY_INSTALL_DESTINATION variable
message(STATUS CMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME})
if (CMAKE_SYSTEM_NAME STREQUAL "iOS")
  message(STATUS IOS_SELECTED)
  # iOS library install folder path
  set(LIBRARY_INSTALL_DESTINATION ${CMAKE_SOURCE_DIR}/ios)
elseif(NOT "${ANDROID_ABI}" STREQUAL "")
  message(STATUS ANDROID_SELECTED)
  # Android library install folder path
  set(LIBRARY_INSTALL_DESTINATION ${CMAKE_SOURCE_DIR}/android)
else()
  message(STATUS HOST_SELECTED)
  # Host library onstall folder path
  set(LIBRARY_INSTALL_DESTINATION ${CMAKE_SOURCE_DIR}/host)
endif()

set(3RD_PARTY_DIR ${CMAKE_SOURCE_DIR}/3rdparty)

if(STAGE STREQUAL "1")
  add_subdirectory(patchmatch)
elseif(STAGE STREQUAL "2")
  # ... etc
else()
  # After all steps will be done at least one just patchmatch
  # directory will be used by default
  add_subdirectory(patchmatch)
endif()

