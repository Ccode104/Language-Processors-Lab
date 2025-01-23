%{

// Question : Count the the number of tokens in the for loop. Also identify the identifiers and keywords

// Definition Section
int no_of_tokens = 0;
 
%}

identifier [a-zA-Z_][a-zA-Z_0-9]*
keyword	   ("for"|"int")
operator  [+\-=)(*%!^/]|"++"|"--"|"<="
other	   [;]|([0-9}{]*)

%%

{keyword}       { printf("%s is a keyword\n",yytext); no_of_tokens++; }
{identifier}	{ printf("%s is a identifier\n",yytext); no_of_tokens++; }
{operator}|{other}	{ no_of_tokens++; }
[\t\n ]		;
<<EOF>>		{ return 0; }
			
%%

	/*User Code*/

int main(int argc, char *argv[])
{
	FILE *file = NULL;
	file = fopen(argv[1],"r");
	
	yyin = file;
	
	yylex();
	printf("\nNumber of tokens = %d\n",no_of_tokens);

	return 0;
}
