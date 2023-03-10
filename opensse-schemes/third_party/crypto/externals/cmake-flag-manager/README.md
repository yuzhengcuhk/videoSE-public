# CMake Flag Manager

CMake module to easily play with compile flags by seamlessly detecting their availability and carefully setting them target by target.

## Include into your project

To use [FlagManager.cmake](cmake/FlagManager.cmake), simply add this repository as git submodule into your own repository

```Shell
mkdir externals
git submodule add https://github.com/rbost/cmake-flag-manager.git
```

and adding `externals/cmake-flag-manager/cmake` to your `CMAKE_MODULE_PATH`

```CMake
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/externals/cmake-flag-manager/cmake")
```

You can also simply copy the [FlagManager.cmake](cmake/FlagManager.cmake) file in your repo. However, these will not be updated without re-copying the file.

Finally, include the `FlagManager` package, say in the root CMake file, by add the following lines:
```CMake
find_package(FlagManager)
```

## Usage

The `FlagManager` package defines two functions: `save_compile_option` to save compile options, and `target_apply_saved_options` to apply previously saved options.

### Saving compile options
Use `save_compile_option` to add a new compile options. This function will check if the option is available for either your C or your C++ compiler, and save it to a language-specific list of compile options. The function can be passed a list of options, in which case, the availability of the options will be tested consecutively, in the given order:
```CMake
save_compile_option(-Wall -Wextra)
```

Note that, by default, the availability of the flag will be checked for both the C and C++ compilers. 
If you want to only check a flag on the C++ compiler, use the `CXX_ONLY` option:
```CMake
save_compile_option(CXX_ONLY -Weffc++)
```

Several option lists can be used, so to support multiple configurations for multiple targets.
To save an option to a specific list, use the `LIST_NAME` option:
```CMake
save_compile_option(LIST_NAME "Errors" -Werror)
```

### Applying compile options
The `target_apply_saved_options` function is used to apply the saved options to a list of targets:
```CMake
target_apply_saved_options(MyLib MyExe)
```

To apply a specific option list, use the `LIST_NAME` option as follows:
```CMake
target_apply_saved_options(LIST_NAME "Errors" MyLib)
```


## License

This CMake module is released under the MIT license. See the [LICENSE](LICENSE) file for more information.




