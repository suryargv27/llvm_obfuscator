# Code Obfuscation Pipeline using Clang, LLVM, and Custom Passes

This project demonstrates a multi-stage code obfuscation pipeline using Clang/LLVM, Python-based preprocessing, and LLVM passes. It is designed to transform a simple `test.cpp` C++ source file into an obfuscated Windows executable with anti-debugging features, dynamic API resolution, and string encryption.

## Project Structure

```
.
├── README.md               # Project documentation
├── CMakeLists.txt          # Root CMake configuration
├── build.sh                # End-to-end build and obfuscation script
├── test.cpp                # Input test file
├── run.sh                  # Run script
├── peb.h                   # Header for PEB walk
├── api_ob.py               # Python script for WinAPI dynamic resolution
├── winapi.csv              # Database of WinAPI function metadata
├── obfuscated.exe          # Final obfuscated executable
├── original.exe            # Original non-obfuscated executable
├── output/                 # Directory for intermediate and final outputs
├── anti_debug_files/       # Anti-debugging C source and compiled IR
├── anti_debug_pass/        # LLVM pass to insert anti-debugging logic
│ ├── CMakeLists.txt
│ └── debug_checker.cpp
├── encrypt_pass/           # LLVM pass for string obfuscation
│ ├── CMakeLists.txt
│ └── encrypter.cpp
├── runner/                 # Pass manager runner binary
│ ├── CMakeLists.txt
│ └── passer.cpp
└── build/                  # CMake build output (auto-generated)
```

## Pipeline Overview

### Input

* `test.cpp`: The input source file you want to obfuscate.


### WinAPI Obfuscation (Python Preprocessing)

* Script: `api_ob.py`
* Goal: Replace static calls to WinAPI functions (like `CreateFile`, `MessageBox`) with dynamic calls via `LoadLibraryA` and `GetProcAddress`.
* Data Source: Uses `winapi.csv`, which contains:

    ```
    function_name,return_type,arg_types,arg_count,dll_name
    ```
* Mechanism:

    * Parses `test.cpp` using Python Clang bindings.
    * Identifies known API calls.
    * Rewrites them into code that loads the function at runtime using function pointers.
* Output: `t1.cpp`

### Generate LLVM IR

* Uses `clang++` to compile `t1.cpp` to LLVM IR (`t1.ll`):

    ```bash
    clang++ -target x86_64-pc-windows-gnu -emit-llvm -S output/t1.cpp -o output/t1.ll
    ```

### Compile Anti-Debugging Files

* Folder: `anti_debug_files/`
* Contains `.c` files implementing a wide range of anti-debugging and anti-VM techniques (e.g., VEH handlers, API flags, breakpoint detection).
* Each `.c` file is compiled to its own `.ll` using:

    ```bash
    clang -target x86_64-pc-windows-gnu -S -emit-llvm file.c -o file.ll
    ```

### Link All IR Files

* Combine:

    * `t1.ll` (transformed main)
    * `VEH.ll`, `APIflags.ll`, `antiVMbreakpoints.ll`, `antiDebugTechniques.ll`, `extraChecks.ll`
* Into a single `t2.ll`:

    ```bash
    llvm-link -S -o output/t2.ll t1.ll ... others ...
    ```

### Pass 1: Insert Anti-Debug Checks

* Pass: `insert-sandbox-checks`
* Behavior: Inserts the following logic at the beginning of `main()`:

    ```c
    if(func1() || func2() || func3()) {
        printf("BYE");
        return 0;
    }
    ```
* Purpose: Exit early if debugging/VM artifacts are detected.

### Pass 2: String Obfuscation

* Pass: `string-obfuscator-pass`
* Behavior:

    * Scans all constant strings in the IR.
    * Replaces each with an encrypted version using a simple increment cipher.
    * Inserts runtime decryption logic (stub) before string usage.
* Result: Obfuscated string contents not easily visible in binary.

### Final Compilation

* Convert final `t4.ll` to `obfuscated.exe`:

    ```bash
    clang -target x86_64-pc-windows-gnu output/t4.ll -o obfuscated.exe
    ```


## Build and Run Instructions

This project provides a modular code obfuscation and analysis pipeline for Windows executables using LLVM and custom Clang/LLVM passes. The pipeline is automated using two scripts: `build.sh` and `run.sh`.

### Build Script (`build.sh`)

The `build.sh` script is used to build all required LLVM passes and tooling needed for the obfuscation process.

#### What It Does:

* Cleans any previous `build` directory.
* Creates a new `build` directory.
* Runs `cmake` to configure the build.
* Compiles the project using `make`.

#### Usage:

```bash
./build.sh
```

This will build your custom LLVM passes (like `InsertSandboxChecksPass` and `StringObfuscatorPass`) and place them under `./build`.


### Run Script (`run.sh`)

The `run.sh` script provides a flag-based interface to control the obfuscation pipeline. It supports WinAPI obfuscation, anti-debugging injection, and string encryption.

#### Available Flags:

| Flag             | Description                                                              |
| ---------------- | ------------------------------------------------------------------------ |
| `--api`          | Enables dynamic WinAPI resolution via `LoadLibraryA` + `GetProcAddress`. |
| `--anti-debug`   | Injects anti-debugging functions and passes.                             |
| `--string-enc`   | Encrypts all string literals using a custom LLVM string pass.            |
| `--all`          | Enables all of the above techniques.                                     |
| `--clean`        | Cleans the `output` directory before processing.                         |
| `--input <file>` | Specifies the input C++ source file (default: `test.cpp`).               |
| `--help`         | Shows usage information.                                                 |

#### Output Structure:

Intermediate and final outputs are stored under the `output/` directory:

* `t1.cpp`: Transformed source (after API obfuscation).
* `t1.ll` → `t4.ll`: Intermediate LLVM IR at each stage.
* `obfuscated.exe`: Final obfuscated Windows executable.

#### Usage Examples:

Run only with WinAPI obfuscation:

```bash
./run.sh --api
```

Run with all techniques:

```bash
./run.sh --all
```

Run with custom input file:

```bash
./run.sh --input mycode.cpp --all
```

Clean output before running:

```bash
./run.sh --clean --all
```



## Requirements

To build and run this project, make sure your system meets the following requirements.

### Operating System

* **Linux** (Tested on Ubuntu)

  * This project is designed to be built and executed on Linux.
  * Final output targets **Windows** executables via cross-compilation using MinGW.


### System Dependencies

| Tool           | Version            | Notes                                                    |
| -------------- | ------------------ | -------------------------------------------------------- |
| **LLVM/Clang** | `18.1.3`           | Required for compiling and running LLVM passes.          |
| **CMake**      | `3.20+`            | Used to configure and build the custom LLVM passes.      |
| **Make**       | Any recent version | For compiling after CMake configuration.                 |
| **Python**     | `3.12.3`           | Used for preprocessing steps like WinAPI transformation. |
| **MinGW-w64**  | Latest available   | Cross-compilation to Windows (`x86_64-w64-mingw32`).     |


### Python Packages


```bash
pip install pandas clang
sudo apt install libclang-dev
```






