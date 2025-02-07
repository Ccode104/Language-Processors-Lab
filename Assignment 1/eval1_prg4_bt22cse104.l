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
