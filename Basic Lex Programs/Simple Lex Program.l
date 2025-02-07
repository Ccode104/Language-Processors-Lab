%%

%{ /* Works like the 'cat' command */
/* . matches any string except '\n' */
/* | stands for 'OR' */
/* ECHO is same as printing the matched character */  
%}

.|\n	ECHO;

%%
