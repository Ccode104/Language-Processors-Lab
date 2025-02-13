%{
    /*Definition Section*/

#include "mini_c.tab.h"  // This will make the lexer know the token names ('DEFINE',...)
#include <stdlib.h> 
#include <string.h>
int lineno = 0;
%}

%%
    /* Section 1 - They are not associated with values in the pair <token name, token value> */
    /* Also, they are put first since we do not want them to match other REGEX */ 

"#define"            { printf("%s [DEFINE]\n", yytext); return DEFINE; }     // Identify the MACRO DEFINE
"#include"          { printf("%s [INCLUDE]\n", yytext); return INCLUDE; }     // Identify the preprocessor directive 'include'
"<"[a-zA-Z0-9._]+">" { printf("%s [DIRECTIVE]\n", yytext); return DIRECTIVE; }  // The argument for #include (the header file) - enclosed within <>

    /* Data Types */
"int"               { printf("%s [DATATYPE]\n", yytext); return DATATYPE; }
"float"             { printf("%s [DATATYPE]\n", yytext); return DATATYPE; }
"char"              { printf("%s [DATATYPE]\n", yytext); return DATATYPE; }
"void"              { printf("%s [DATATYPE]\n", yytext); return DATATYPE; }

    /* Keywords */
"if"                { printf("%s [IF]\n", yytext); return IF; }
"else"              { printf("%s [ELSE]\n", yytext); return ELSE; }

    /* Section 2 - Tokens with associated values */
[0-9]+              { printf("%s [NUMBER]\n", yytext); yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { printf("%s [IDENTIFIER]\n", yytext); yylval.id = strdup(yytext); return IDENTIFIER; }

    /* Section 3 - Operators and Symbols (No associated value) */
"+"                 { printf("%s [PLUS]\n", yytext); return PLUS; }
"-"                 { printf("%s [MINUS]\n", yytext); return MINUS; }
"*"                 { printf("%s [MUL]\n", yytext); return MUL; }
"/"                 { printf("%s [DIV]\n", yytext); return DIV; }
"%"                 { printf("%s [MOD]\n", yytext); return MOD; }
","                 { printf("%s [COMMA]\n", yytext); return COMMA; }
"="                 { printf("%s [ASSIGN]\n", yytext); return ASSIGN; }
";"                 { printf("%s [SEMICOLON]\n", yytext); return SEMICOLON; }
"("                 { printf("%s [LPAREN]\n", yytext); return LPAREN; }
")"                 { printf("%s [RPAREN]\n", yytext); return RPAREN; }
"{"                 { printf("%s [LBRACE]\n", yytext); return LBRACE; }
"}"                 { printf("%s [RBRACE]\n", yytext); return RBRACE; }
"=="                { printf("%s [EQ]\n", yytext); return EQ; }
"!="                { printf("%s [NEQ]\n", yytext); return NEQ; }
"<"                 { printf("%s [LT]\n", yytext); return LT; }
">"                 { printf("%s [GT]\n", yytext); return GT; }
"<="                { printf("%s [LEQ]\n", yytext); return LEQ; }
">="                { printf("%s [GEQ]\n", yytext); return GEQ; }

    /* Section 4 - Ignored elements */
"//"[^\n]*          { /* Skip single-line comments */ }
"/\*"([^*]|\*+[^*/])*\*+"/"   { /* Skip multi-line comments */ }
[ \t\n]+            { /* Ignore whitespace */ }
.                   { printf("Unexpected character: %s\n", yytext); }

%%

// This function decides what to do when we reach EOF
int yywrap() {
    return 1;
}