%{
/* Definition */
#include<ctype.h>
%}

%%


"//".*	|	
"/*"[^*]*"*/"	{ for(int i=0;i<yyleng;i++) printf("%c",toupper(*(yytext+i))); }
.|\n		ECHO;
<<EOF>>   { return 0; }

%%

/*User Code*/

yywrap()
{

}

int main()
{
	yylex();
	return 0;
}
