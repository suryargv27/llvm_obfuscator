#!/bin/bash
# set -e # Exit on any error
# set -x # Echo commands


# Default values
API_OBF=0
ANTI_DEBUG=0
STRING_ENC=0
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
    --input)
        shift
        INPUT_FILE="$1"
        ;;
    --help)
        echo "Usage: $0 [options]"
        echo
        echo "Options:"
        echo "  --api           Enable WinAPI obfuscation"
        echo "  --anti-debug    Enable anti-debug instrumentation"
        echo "  --string-enc    Enable string encryption"
        echo "  --all           Enable all techniques"
        echo "  --input FILE    Specify input C/C++ file inside input/ folder"
        echo "  --help          Show this help message"
        exit 0
        ;;
    *)
        echo "Unknown option: $1"
        echo "Usage: $0 [--api] [--anti-debug] [--string-enc] [--all] [--input file]"
        exit 1
        ;;
    esac
    shift
done

# Check if input file exists
if [ ! -f "input/$INPUT_FILE" ]; then
    echo "[!] Error: Input file 'input/$INPUT_FILE' not found."
    exit 1
fi


# Clean output
rm -rf output
mkdir -p output

# Set Compiler
cd input
EXT="${INPUT_FILE##*.}"
if [[ "$EXT" == "cpp" ]]; then
    COMPILER="clang++"
else
    COMPILER="clang"
fi
cd ..
cp input/* output/


# Compile non-obfuscated file
echo "Generating Non-Obfuscated file original.exe"
$COMPILER -target x86_64-pc-windows-gnu output/"$INPUT_FILE" -o output/original.exe

# Step 1: WinAPI Obfuscation
if [ "$API_OBF" -eq 1 ]; then
    echo "Performing WinAPI Obfuscation"
    python3 api_pass/api_ob.py --input output/"$INPUT_FILE" --output output/t1."$EXT" --db api_pass/winapi.csv
    cp api_pass/peb.h output/peb.h
else
    cp output/"$INPUT_FILE" output/t1."$EXT"
fi

# Step 2: Compile to LLVM IR
$COMPILER -target x86_64-pc-windows-gnu -emit-llvm -S output/t1."$EXT" -o output/t1.ll

# Step 3: Compile anti-debug files and link if enabled
if [ "$ANTI_DEBUG" -eq 1 ]; then
    echo "Performing Anti Debug checks"
    cd anti_debug_files
    clang -target x86_64-pc-windows-gnu -S -emit-llvm anti-vm.c -o anti-vm.ll
    clang -target x86_64-pc-windows-gnu -S -emit-llvm vectoredExceptionHandler.c -o vectoredExceptionHandler.ll
    clang -target x86_64-pc-windows-gnu -S -emit-llvm anti-analysis.c -o anti-analysis.ll
    llvm-link -S -o ../output/t2.ll ../output/t1.ll vectoredExceptionHandler.ll anti-vm.ll anti-analysis.ll
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
clang -target x86_64-pc-windows-gnu output/t4.ll -o output/obfuscated.exe
echo "Generating Obfuscated file obfuscated.exe"