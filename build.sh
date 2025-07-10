#!/bin/bash

set -e # Exit on any error
set -x # Echo commands



# Clean and create build directory
rm -rf build
mkdir build
cd build
cmake ..
make


