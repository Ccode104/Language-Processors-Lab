# Mini-C Parser

## Overview
This project implements a parser for a simplified version of the C programming language, called **Mini-C**. The parser verifies whether an input program adheres to the defined syntax of Mini-C.

### **Features**
The parser supports the following elements of the Mini-C language:
- **Macros (`#define`)**
- **Preprocessor directives (`#include`)**
- **Single-line and multi-line comments**
- **Variables**
- **Data Types**: Supports only integers,floats,void and char.
- **Operators**: Supports arithmetic operators (`+`, `-`, `*`, `/`, `%`) and more.
- **Control Structures**: Supports `if-else` statements
- **Assignment Statements**

## **Input & Output**
- **Input**: A lexically valid Mini-C program.
- **Output**: The parser returns `Success` if the program follows the Mini-C syntax; otherwise, it returns `Failure` with an error message indicating the issue.

## **Installation & Setup**
Ensure you have the following installed:
- **Lex/Flex** (Lexical Analyzer Generator)
- **Yacc/Bison** (Parser Generator)
- **GCC** (GNU Compiler Collection)

## **Compilation & Execution**

### **1. Lexical Analysis (Flex)**
Compile the **Lex file** (`lexer.l`):
```sh
flex lexer.l
```
This generates `lex.yy.c`.

### **2. Syntax Analysis (YACC/Bison)**
Compile the **YACC file** (`parser.y`):
```sh
yacc -d parser.y
```
This generates `y.tab.c` and `y.tab.h`.

### **3. Compilation**
Compile the generated files using GCC:
```sh
gcc -o mini_c_parser lex.yy.c y.tab.c -ll
```
This creates an executable named `mini_c_parser`.

### **4. Running the Parser**
To parse a Mini-C program, run:
```sh
./mini_c_parser 
```
where `input.c` is the Mini-C program to be parsed.

### **5. Expected Output**
- If the input program is valid, the output will be:
  ```sh
  Success: The Mini-C program is syntactically correct.
  ```
- If there is a syntax error, the parser will display an error message along with the line number.

## **Example Mini-C Program**
```c
#define MAX 100
#include <stdio.h>

int main() {
    int x = 10;
    int y = 20;
    if (x < y) {
        x = x + y;
    }
    return 0;
}
```
### Note : We used a different example in given input.c file
## **Error Handling**
- The parser provides meaningful error messages, including line numbers, to help identify syntax errors.
- Common errors include:
  - Missing semicolons
  - Incorrect `if-else` syntax
  - Unsupported data types

## **License**
This project is open-source and free to use for educational purposes.

## **Authors**
- Abhishek Prashant Chandurkar
- Manas Sandip Jungade
- Visvesveraya National Institute of Technology, Nagpur
---

## References : Lex and Yacc Manual given in the repository

## NOTE :
Use of AI Tools like ChatGPT was done in order to speed-up the process of writing the parser and lexer.
It is an assignment done only for learning purposes.
We will update the code to make it better than the current version soon. 

