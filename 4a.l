%{
#include <stdio.h>
int kwd = 0;
int id = 0;
int oprt = 0;
%}

%%

"int" kwd++;
"float" kwd++;
"char" kwd++;
[+\-*/=] oprt++;
[_a-zA-Z]+[_a-zA-Z0-9]* id++;
\n {/*ignore*/};
. {/*ignore everything else too*/};

%%

int yywrap() {
	return 1;
}

int main() {
	yyin = fopen("4a_ip.txt", "r");
	yylex();
	printf("No.of keywords: %d\nNo.of identifiers: %d\nNo.of operators: %d\n", kwd, id, oprt);
	return 1;
}



