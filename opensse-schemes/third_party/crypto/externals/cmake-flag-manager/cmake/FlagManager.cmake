# MIT License

# Copyright (c) 2019 Raphael Bost

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

cmake_minimum_required(VERSION 3.0)

if(__flag_manager)
    return()
endif()
set(__flag_manager YES)

if(${CMAKE_VERSION} VERSION_LESS "3.5.0")
    include(CMakeParseArguments)
endif()

include(CheckCCompilerFlag)
include(CheckCXXCompilerFlag)

function(save_compile_option)

    set(options CXX_ONLY)
    set(oneValueArgs LIST_NAME)
    set(multiValueArgs)

    cmake_parse_arguments(
        ARGUMENTS
        "${options}"
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN}
    )

    string(LENGTH "${ARGUMENTS_LIST_NAME}" LN_LENGTH)

    if(LN_LENGTH EQUAL 0)
        set(LIST_NAME "LIST")
    else()
        set(LIST_NAME ${ARGUMENTS_LIST_NAME})
    endif()

    set(CFLAG_LIST_NAME "SAVED_CFLAG_${LIST_NAME}")
    set(CXXFLAG_LIST_NAME "SAVED_CXXFLAG_${LIST_NAME}")

    set(CFLAG_LIST)
    set(CXXFLAG_LIST)

    foreach(_flag ${ARGUMENTS_UNPARSED_ARGUMENTS})

        string(
            REGEX
            REPLACE
                "[-=]"
                "_"
                stripped_flag
                ${_flag}
        )

        set(FLAG_VARNAME "COMPILE_FLAG${stripped_flag}_SUPPORTED")
        set(CFLAG_VARNAME "C_${FLAG_VARNAME}")
        set(CXXFLAG_VARNAME "CXX_${FLAG_VARNAME}")

        if(NOT ${ARGUMENTS_CXX_ONLY})
            check_c_compiler_flag(${_flag} ${CFLAG_VARNAME})
            if(${CFLAG_VARNAME})
                list(APPEND ${CFLAG_LIST_NAME} ${_flag})
            endif()
        endif()

        check_cxx_compiler_flag(${_flag} ${CXXFLAG_VARNAME})
        if(${CXXFLAG_VARNAME})
            list(APPEND ${CXXFLAG_LIST_NAME} ${_flag})
        endif()

    endforeach(_flag ${ARGN})

    # message(STATUS "Final C Flags: ${${CFLAG_LIST_NAME}}") message(STATUS
    # "Final CXX Flags: ${${CXXFLAG_LIST_NAME}}")

    set(${CFLAG_LIST_NAME} ${${CFLAG_LIST_NAME}} PARENT_SCOPE)
    set(${CXXFLAG_LIST_NAME} ${${CXXFLAG_LIST_NAME}} PARENT_SCOPE)

endfunction(save_compile_option)

function(target_apply_saved_options)
    set(options PUBLIC)
    set(oneValueArgs LIST_NAME)
    set(multiValueArgs)

    cmake_parse_arguments(
        ARGUMENTS
        "${options}"
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN}
    )

    string(LENGTH "${ARGUMENTS_LIST_NAME}" LN_LENGTH)

    if(LN_LENGTH EQUAL 0)
        set(LIST_NAME "LIST")
    else()
        set(LIST_NAME ${ARGUMENTS_LIST_NAME})
    endif()

    set(CFLAG_LIST_NAME "SAVED_CFLAG_${LIST_NAME}")
    set(CXXFLAG_LIST_NAME "SAVED_CXXFLAG_${LIST_NAME}")

    foreach(_target ${ARGUMENTS_UNPARSED_ARGUMENTS})

        if(${ARGUMENTS_PUBLIC} EQUAL TRUE)
            target_compile_options(
                ${_target}
                PUBLIC $<$<COMPILE_LANGUAGE:C>:${${CFLAG_LIST_NAME}}>
            )
            target_compile_options(
                ${_target}
                PUBLIC $<$<COMPILE_LANGUAGE:CXX>:${${CXXFLAG_LIST_NAME}}>
            )
        else()
            target_compile_options(
                ${_target}
                PRIVATE $<$<COMPILE_LANGUAGE:C>:${${CFLAG_LIST_NAME}}>
            )
            target_compile_options(
                ${_target}
                PRIVATE $<$<COMPILE_LANGUAGE:CXX>:${${CXXFLAG_LIST_NAME}}>
            )
        endif()

    endforeach()
endfunction(target_apply_saved_options)
