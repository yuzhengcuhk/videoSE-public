cmake_minimum_required (VERSION 3.1)

project (dbparser VERSION 0.2 
                      DESCRIPTION "OpenSSE's database parser library")

add_library(dbparser SHARED
                DBParser.cpp
                json/DBParserJSON.cpp)

set_target_properties(dbparser PROPERTIES POSITION_INDEPENDENT_CODE ON)
target_compile_features(dbparser
    PUBLIC
        cxx_auto_type
        cxx_nullptr
        cxx_constexpr
        cxx_defaulted_functions
        cxx_deleted_functions
        cxx_extern_templates
        cxx_noexcept
        cxx_static_assert
        cxx_thread_local
    PRIVATE
        cxx_lambdas
)

target_include_directories(dbparser PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
    PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} 
    PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include/sse/dbparser)



# Installation

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

install(TARGETS dbparser EXPORT OpenSSEDBParserTargets
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR} 
        )
install(DIRECTORY include DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})


## CMake magic

install(EXPORT OpenSSEDBParserTargets 
        FILE OpenSSEDBParserTargets.cmake
        NAMESPACE OpenSSE::
        DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/sse"
        )
export(TARGETS dbparser NAMESPACE OpenSSE:: 
                        FILE OpenSSEDBParserTargets.cmake)

write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/OpenSSEDBParserConfigVersion.cmake
    VERSION ${sse_dbparser_VERSION}
    COMPATIBILITY AnyNewerVersion
    )

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/OpenSSEDBParserConfigVersion.cmake
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/sse
        )


# Add an alias
add_library(OpenSSE::dbparser ALIAS dbparser)
