%{
/* Definition */
#include<ctype.h>
%}

%%

"auto"       |
"break"      |
"case"       |
"char"       |
"const"      |
"continue"   |
"default"    |
"do"         |
"double"     |
"else"       |
"enum"       |
"extern"     |
"float"      |
"for"        |
"goto"       |
"if"         |
"int"        |
"long"       |
"register"   |
"return"     |
"short"      |
"signed"     |
"sizeof"     |
"static"     |
"struct"     |
"switch"     |
"typedef"    |
"union"      |
"unsigned"   |
"void"       |
"volatile"   |
"while"      |
^[#][^\n]*	        |
\/\*[^*]*\*\/   	|
"//".*			|
\".*\"			ECHO;

[a-zA-Z_]([a-zA-Z0-9_])*	{ for(int i=0;i<yyleng;i++) printf("%c",toupper(*(yytext+i))); }
.|\n  				ECHO; 
<<EOF>>   			{ return 0; }

%%

/*User Code*/

yywrap()
{

}

int main(int argc , char *argv[])
{
        FILE *file = NULL;

        if(argc==1)
        {
                printf("Please enter the file name\n");
                return 0;
        }

        file = fopen(argv[1],"r");
        if(file != NULL)
                yyin = file;
        else
        {
                printf("File does not exist\n");
                return 0;
        }
	yylex();
	return 0;
}
