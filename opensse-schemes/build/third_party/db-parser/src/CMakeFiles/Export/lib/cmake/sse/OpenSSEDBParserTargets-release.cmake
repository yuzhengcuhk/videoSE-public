#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "OpenSSE::dbparser" for configuration "Release"
set_property(TARGET OpenSSE::dbparser APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenSSE::dbparser PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libdbparser.so"
  IMPORTED_SONAME_RELEASE "libdbparser.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenSSE::dbparser )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenSSE::dbparser "${_IMPORT_PREFIX}/lib/libdbparser.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
