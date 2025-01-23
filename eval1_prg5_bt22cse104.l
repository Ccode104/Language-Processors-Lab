%{

// Question : String contains "101" as a subsequence

// Definition Section

%}

subsequence [^\t\n a-zA-Z2-9]*1[^\t\n a-zA-Z2-9]*0[^\t\n a-zA-Z2-9]*1

%%
	/*Rules Section*/

{subsequence}	{ printf("%s contains 101 as a subsequence\n",yytext); }
[^\t\n ]*	{ printf("%s does not contain 101 as a subsequence\n",yytext); }
[\t\n ]		;
<<EOF>>		{ return 0; }

%%

int main(int argc , char *argv[])
{

	FILE *file = NULL;
	file = fopen(argv[1],"r");
	
	yyin = file;
	
	yylex();
	return 0;
}
 
