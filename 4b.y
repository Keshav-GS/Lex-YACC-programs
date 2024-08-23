%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char* s);
int cnt = 0;
%}

%token IF NUM EXP

%%

S: I;

I: IF A B {cnt++;};

A: '(' EXP ')'
 | '(' NUM ')'
 ;
 
B: '{' B '}'
 | I
 | /*empty*/
 ;

%%

void yyerror(const char* s) {
	fprintf(stderr, "Invalid!\n");
	exit(1);
}

int main() {
	yyparse();
	printf("No.of nested IF's are: %d\n", cnt);
	return 1;
}
