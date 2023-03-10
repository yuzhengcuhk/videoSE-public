#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "OpenSSE::sse_crypto" for configuration "Release"
set_property(TARGET OpenSSE::sse_crypto APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(OpenSSE::sse_crypto PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libsse_crypto.so"
  IMPORTED_SONAME_RELEASE "libsse_crypto.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenSSE::sse_crypto )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenSSE::sse_crypto "${_IMPORT_PREFIX}/lib/libsse_crypto.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
