%{
/* References : https://stackoverflow.com/questions/50125126/what-is-a-literal-string-char-array-in-c */
// Definition section
#include<ctype.h>

%}

character_literals [ =][']([^']|\n|(\'))+['][ ,;]
string_literal     [ =]\"([^"]|(\\\"))+\"[ ,;]


%%

	/*Rules Section*/

{character_literals}	|
{string_literal}	{ for(int i=0;i<yyleng;i++) printf("%c",toupper(yytext[i])); }

%%

// User Code

int main()
{
	yylex();
	return 0;
}
