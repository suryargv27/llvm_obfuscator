cmake_minimum_required(VERSION 3.13)
project(StringObfuscatorProject)

# Find LLVM (must set LLVM_DIR when configuring)
find_package(LLVM REQUIRED CONFIG)

# Required for LLVM passes and tools
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(HandleLLVMOptions)
include(AddLLVM)

# Add subdirectories
add_subdirectory(encrypt_pass)
add_subdirectory(runner)
add_subdirectory(anti_debug_pass)