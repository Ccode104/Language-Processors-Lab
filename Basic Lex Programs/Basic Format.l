%{
/* This is the definition section. We can include the header files here and write C code as well. */
%}

%%

%{
/* Here comes the 'Rules' section where we write the regular expressions */ 
%}

[\t ]+		/*ignore the whitespace*/

is |
am |
are |
were |
was |
be |
being |
been |
do |
does |
did |
should |
can |
could |
has |
have |
had |
go { printf("%s: is a verb\n", yytext); /*This part will changes as pr application.Here, we identify the verbs. yytext is an array pointer pointing to the matched string*/}
[a-zA-Z]+	{printf("%s",yytext);}
.|\n		{ ECHO; /*Default Action*/ }
<<EOF>>		{ return 0; /*If the input is a file , the lexical analyser we terminate once it reaches the EOF*/ }
