#!/bin/bash
# set -e # Exit on any error
# set -x # Echo commands


# Default values
API_OBF=0
ANTI_DEBUG=0
STRING_ENC=0
CLEAN=0
INPUT_FILE="test.cpp"

# Parse flags
while [[ $# -gt 0 ]]; do
    case "$1" in
    --api)
        API_OBF=1
        ;;
    --anti-debug)
        ANTI_DEBUG=1
        ;;
    --string-enc)
        STRING_ENC=1
        ;;
    --all)
        API_OBF=1
        ANTI_DEBUG=1
        STRING_ENC=1
        ;;
    --clean)
        CLEAN=1
        ;;
    --input)
        shift
        INPUT_FILE="$1"
        ;;
    --help)
        echo "Usage: $0 [--api] [--anti-debug] [--string-enc] [--all] [--clean] [--input file.cpp] [--help]"
        exit 1
        ;;
    *)
        echo "Unknown option: $1"
        echo "Usage: $0 [--api] [--anti-debug] [--string-enc] [--all] [--clean] [--input file.cpp]"
        exit 1
        ;;
    esac
    shift
done

# Check input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' not found!"
    exit 1
fi

# Step 0: Clean output if needed
if [ "$CLEAN" -eq 1 ]; then
    rm -rf output
fi
mkdir -p output

echo "Generating Non-Obfuscated file original.exe"
clang++ -target x86_64-pc-windows-gnu "$INPUT_FILE" -o original.exe

# Step 1: WinAPI Obfuscation
if [ "$API_OBF" -eq 1 ]; then
    echo "Performing WinAPI Obfuscation"
    python3 api_ob.py --input "$INPUT_FILE" --output output/t1.cpp
    cp peb.h output/peb.h
else
    cp "$INPUT_FILE" output/t1.cpp
fi

# Step 2: Compile to LLVM IR
clang++ -target x86_64-pc-windows-gnu -emit-llvm -S output/t1.cpp -o output/t1.ll

# Step 3: Compile anti-debug files and link if enabled
if [ "$ANTI_DEBUG" -eq 1 ]; then
    echo "Performing Anti Debug checks"
    cd anti_debug_files
    clang -target x86_64-pc-windows-gnu -S -emit-llvm antiVMbreakpoints.c -o antiVMbreakpoints.ll
    clang -target x86_64-pc-windows-gnu -S -emit-llvm APIflags.c -o APIflags.ll
    clang -target x86_64-pc-windows-gnu -S -emit-llvm debug.c -o debug.ll
    clang -target x86_64-pc-windows-gnu -S -emit-llvm timeUI.c -o timeUI.ll
    clang -target x86_64-pc-windows-gnu -S -emit-llvm vectoredExceptionHandler.c -o vectoredExceptionHandler.ll
    clang -target x86_64-pc-windows-gnu -S -emit-llvm vm.c -o vm.ll
    llvm-link -S -o ../output/t2.ll ../output/t1.ll APIflags.ll antiVMbreakpoints.ll debug.ll timeUI.ll vectoredExceptionHandler.ll vm.ll
    cd ..
else
    cp output/t1.ll output/t2.ll
fi

# Step 4: Insert anti-debug instrumentation if enabled
if [ "$ANTI_DEBUG" -eq 1 ]; then
    ./build/runner/passer \
        output/t2.ll \
        -load-pass-plugin ./build/anti_debug_pass/InsertSandboxChecksPass.so \
        -passes=insert-sandbox-checks \
        -o output/t3.ll
else
    cp output/t2.ll output/t3.ll
fi

# Step 5: String obfuscation if enabled
if [ "$STRING_ENC" -eq 1 ]; then
    echo "Performing String encryption"
    ./build/runner/passer \
        output/t3.ll \
        -load-pass-plugin ./build/encrypt_pass/StringObfuscatorPass.so \
        -passes=string-obfuscator-pass \
        -o output/t4.ll
else
    cp output/t3.ll output/t4.ll
fi

# Step 6: Final compile
clang -target x86_64-pc-windows-gnu output/t4.ll -o obfuscated.exe
echo "Generating Obfuscated file obfuscated.exe"