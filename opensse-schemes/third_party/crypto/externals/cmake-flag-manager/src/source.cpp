#include <iostream>
#include <string>

void cpp_test_function(const std::string &str) {
  std::cout << str;
  (char &)(str[0]) = '1'; // raises an error due to -Wcast-qual
}