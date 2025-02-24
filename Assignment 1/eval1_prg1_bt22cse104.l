%{
// Definition Section

// Counters for integers and floats
int no_of_integers = 0 ;
int no_of_floats = 0 ; 
%}

float 	[ =]([0-9])+\.([0-9])+[ ,;] 
integer [ =]([0-9])+[ ,;]

%%

	/* Rules Section */

	/* Found floating point number */
{float} {no_of_floats++;}	
	
	/* Found Integer */
{integer} {no_of_integers++;}

	/* Otherwise do nothing */
.|\n ;

	/* Termination condition */
<<EOF>> {return 0;}

%%

/* User Code */

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
	printf("Number of integers is %d\n",no_of_integers);
	printf("Number of floats is %d\n",no_of_floats);
	return 0;
}
