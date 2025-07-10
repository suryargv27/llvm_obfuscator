# Build the LLVM pass as a plugin
add_llvm_pass_plugin(StringObfuscatorPass
  encrypter.cpp
)