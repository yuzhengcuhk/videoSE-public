cmake_minimum_required(VERSION 3.0)

project(
    cmake-flag-manager DESCRIPTION
    "A manager for C/C++ compiler flags in CMake"
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

include(FlagManager)

save_compile_option(-Wall -Wextra -Wgibberish)
save_compile_option(CXX_ONLY -Weffc++)

save_compile_option(LIST_NAME "Errors" CXX_ONLY -Werror -Wextra-semi -Wpedantic -Wcast-qual -Wno-error=unknown-pragmas)


add_library(test_target src/source.cpp src/source.c)

target_apply_saved_options(test_target)
target_apply_saved_options(LIST_NAME "Errors" test_target)