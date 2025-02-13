%{
    	/*Definition Section*/

	/* This will be copied verbatim(as it is) into y.tab.c(renamed as mini_c.tab.c) */
#include <stdio.h>
#include <stdlib.h>


	/* It is executed when there is an error while parsing */
void yyerror(const char *s);

	/* The Lexer Function */
int yylex();
	
	/* yyin is used to read input from the file input.txt */
extern FILE *yyin; // Input file

%}

	/* We define a union for storing the token value - numeric or pointer to symbol table entry */
%union {
    int num;
    char *id;
}

%left EQ NEQ LT GT LEQ GEQ
%left PLUS MINUS
%left MUL DIV



	/* Tokens that we are concerned with */
	/* These token do not have a token value */

%token DEFINE INCLUDE IF ELSE OPERATOR DATATYPE DIRECTIVE
%token ASSIGN SEMICOLON LPAREN RPAREN LBRACE RBRACE COMMA PLUS MINUS MUL DIV MOD

	/* These token have wither a numeric token value (num) or pointer to symbol table as token value (id) */
%token <num> NUMBER
%token <id> IDENTIFIER
%type <num> expression
%type <num> T
%type <num> F

	/* Tokens associated with comparison operators */
%token EQ NEQ LT GT LEQ GEQ

%%

	/* Rules Section */
	/* The first rule by default defines the start symbol -> program . This is the root of the parse tree */ 

    /* A program can have preprocessor directives OR statements OR function declarations */

program:
    preprocessor_directives program         /* Preprocessor directives comes at the beginning */		
    | statements                            /* Statements */
    | function_dec                          /* Function Declaration */
    | declaration
    ;


    /* Directives and Macros both*/
    /* #define SIZE 10 */
preprocessor_directives:
    DEFINE IDENTIFIER NUMBER
    | INCLUDE DIRECTIVE
    ;

	/* The function declaration is of the form : datatype func_name(arg list) { function body } */
    /* int fun(int a,float b,....){ statements }  */


function_dec:
    DATATYPE IDENTIFIER LPAREN argument RPAREN LBRACE statements RBRACE
    ;
	/* int a , float b ,.....*/

argument:
    | DATATYPE IDENTIFIER arg_rec
    ;

	/* Recursive */
arg_rec:
    COMMA DATATYPE IDENTIFIER arg_rec
    |
    ;
	
	/* Recursive - collection of statements */
statements:
    | statements statement
    ;

	/* Statement ends with a declaration OR assignment. It can also be a if statement*/
statement:
    declaration
    | assignment
    | if_statement
    ;
	
    /* Declaration -> int a = expression , b = expression ,c,d = expression,.........;float .......; */
declaration:
    DATATYPE IDENTIFIER declaration_rec
    | DATATYPE IDENTIFIER ASSIGN expression declaration_rec 
    ;

	/* Recursive */
declaration_rec:
    COMMA IDENTIFIER declaration_rec
    | COMMA IDENTIFIER ASSIGN expression declaration_rec 
    | SEMICOLON
    ;

	/* a = expression , b = expression ,.......;;*/
assignment:
    IDENTIFIER ASSIGN expression SEMICOLON
    | IDENTIFIER ASSIGN expression COMMA assignment
    ;

	/* if ( expression ) { statements } else if(expression) {statements} else {statements}*/
if_statement:
    IF LPAREN expression RPAREN LBRACE statements RBRACE %prec IF       
    | IF LPAREN expression RPAREN LBRACE statements RBRACE ELSE LBRACE statements RBRACE
    | IF LPAREN expression RPAREN LBRACE statements RBRACE ELSE if_statement
    ;
	/* Defines division and multilication sepeartely, giving it a higher precedence over addition and substraction -> Implicit precedence*/
T:
    T DIV F { $$ = $1 / $3; }
    | T MUL F { $$ = $1 * $3; }
    | F { $$= $1; }
    ;
F:
    IDENTIFIER {}
    | NUMBER { $$ = $1; }
    | LPAREN expression RPAREN { $$ = $2; }
    ;

	/* expression opeartor expression OR expression +/- T*/
expression:
    expression PLUS T { $$ = $1 + $3; }
    | expression MINUS T { $$ = $1 - $3; }
    | expression EQ expression { $$ = ($1 == $3); }
    | expression NEQ expression { $$ = ($1 != $3); }
    | expression LT expression { $$ = ($1 < $3); }
    | expression GT expression { $$ = ($1 > $3); }
    | expression LEQ expression { $$ = ($1 <= $3); }
    | expression GEQ expression { $$ = ($1 >= $3); }
    | T { $$ = $1; }
    ;

	/* $i refers the token value of ith terminal/non-terminal on RHS of the rule while $$ refers to LHS of rule */


%%

void yyerror(const char *s) {
    	fprintf(stderr, "Syntax error: %s at %d\n", s,yylineno);
}

int main(void) {
    	FILE *file = fopen("input.txt", "r");
    	if (!file) {
        	perror("Error opening input.txt");
        	return 1;
    	}
    	yyin = file; // Redirect input to file
    
    	// Parsing Function
    	yyparse();
    
	fclose(file);
    	printf("Parsing done successfully\n");
    	return 0;
}
