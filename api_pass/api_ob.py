import argparse
import pandas as pd
import clang.cindex
from clang.cindex import CursorKind

pointers = [
    "HMODULE kernel32baseAddr;\n",
    "GETPROCADDRESS ptrGetProcAddress;\n",
    "LOADLIBRARYA ptrLoadLibraryA;\n",
]

bypass_functions = ["sprintf", "strlen"]


def get_clang_args(input_file):
    args = ["-target", "x86_64-pc-windows-gnu", "-I/usr/x86_64-w64-mingw32/include"]
    if input_file.endswith(".cpp"):
        args += ["-x", "c++"]
    else:
        args += ["-x", "c"]
    return args


def get_typedef(winapi, winapi_csv):
    typedef = [
        '#include "peb.h"\n',
        "typedef FARPROC(WINAPI *GETPROCADDRESS)(HMODULE, LPCSTR);\n",
        "typedef HMODULE(WINAPI *LOADLIBRARYA)(LPCSTR);\n",
    ]
    hmodule = []
    function_ptr = []
    dlls = set()

    for function_name in winapi:
        df = pd.read_csv(winapi_csv)
        row = df.loc[df["function_name"] == function_name].iloc[0]

        dll_name = row["dll_name"].removesuffix(".dll")
        dlls.add(dll_name)
        return_type = row["return_type"]
        arg_types = row["arg_types"].split(";") if row["arg_count"] else []
        args = ", ".join(arg_types)

        typedef.append(
            f"typedef {return_type} (WINAPI *{function_name.upper()})({args});\n"
        )
        function_ptr.append(
            f'{function_name}_ptr = ({function_name.upper()})ptrGetProcAddress({dll_name}_mod, "{function_name}");\n'
        )
        pointers.append(f"{function_name.upper()} {function_name}_ptr;\n")

    for dll in dlls:
        hmodule.append(f'{dll}_mod = ptrLoadLibraryA("{dll}.dll");\n')
        pointers.append(f"HMODULE {dll}_mod;\n")

    return typedef, function_ptr, hmodule


def insert_code(input_file, typedef, hmodule, function_ptr, output_file):
    index = clang.cindex.Index.create()
    tu = index.parse(input_file)

    with open(input_file, "r") as f:
        lines = f.readlines()

    block = 0
    for line in lines:
        if line.startswith("#include"):
            block += 1
        else:
            break

    for cursor in tu.cursor.walk_preorder():
        if cursor.kind == CursorKind.FUNCTION_DECL and cursor.spelling == "main":
            typedef_block = cursor.extent.start.line - 1
            for child in cursor.get_children():
                if child.kind == CursorKind.COMPOUND_STMT:
                    main_block = child.extent.start.line
                    break
            break

    peb_code = [
        "kernel32baseAddr = getkernel32baseAddr();\n",
        'ptrGetProcAddress = (GETPROCADDRESS)GetProcAddressKernel32(kernel32baseAddr, "GetProcAddress");\n',
        'ptrLoadLibraryA = (LOADLIBRARYA)GetProcAddressKernel32(kernel32baseAddr, "LoadLibraryA");\n',
    ]

    lines = (
        lines[:main_block]
        + ["\n"]
        + peb_code
        + ["\n"]
        + hmodule
        + ["\n"]
        + function_ptr
        + ["\n"]
        + lines[main_block:]
    )

    lines = (
        lines[:block] + ["\n"] + typedef + ["\n"] + pointers + ["\n"] + lines[block:]
    )

    with open(output_file, "w") as f:
        f.writelines(lines)


def find_function(input_file, winapi_csv):
    df = pd.read_csv(winapi_csv)
    functions = set(df["function_name"])
    winapi = set()
    args = get_clang_args(input_file)
    index = clang.cindex.Index.create()
    tu = index.parse(input_file, args=args)

    for cursor in tu.cursor.walk_preorder():
        if cursor.kind == CursorKind.CALL_EXPR:
            if cursor.location.file and cursor.location.file.name == input_file:
                function = cursor.spelling
                if function in bypass_functions:
                    continue
                elif function in functions:
                    winapi.add(function)
    return winapi


def rename_functions(winapi, output_file):
    args = get_clang_args(output_file)
    index = clang.cindex.Index.create()
    tu = index.parse(output_file, args=args)

    modifications = {}
    with open(output_file, "r") as f:
        lines = f.readlines()

    for cursor in tu.cursor.walk_preorder():
        if cursor.kind == CursorKind.CALL_EXPR:
            function = cursor.spelling
            if function in winapi:
                line = cursor.location.line - 1
                col = cursor.location.column - 1
                old_line = lines[line]
                new_line = (
                    old_line[:col] + f"{function}_ptr" + old_line[col + len(function) :]
                )
                modifications[line] = new_line

    for line, new_line in modifications.items():
        lines[line] = new_line

    f.close()
    with open(output_file, "w") as f:
        f.writelines(lines)


def main():
    parser = argparse.ArgumentParser(description="WinAPI Obfuscation Tool")
    parser.add_argument("--input", required=True, help="Input .cpp or .c file")
    parser.add_argument("--output", required=True, help="Output .cpp or .c file")
    parser.add_argument(
        "--db", default="winapi.csv", help="Path to WinAPI database CSV"
    )

    args = parser.parse_args()

    input_file = args.input
    output_file = args.output
    winapi_csv = args.db

    winapi = find_function(input_file, winapi_csv)
    typedef, function_ptr, hmodule = get_typedef(winapi, winapi_csv)
    insert_code(input_file, typedef, hmodule, function_ptr, output_file)
    rename_functions(winapi, output_file)


if __name__ == "__main__":
    main()
