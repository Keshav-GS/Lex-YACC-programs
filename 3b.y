%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char* s);
int cnt = 0;
%}

%token FOR EXP NUM INC DEC LE GE

%%

S: I;

I: FOR A B {cnt++;};

A: '(' E ';' E ';' E ')';

B: '{' B '}'
 | I
 | E
 | /*empty*/
 ;
 
E: EXP Z EXP
 | EXP Z NUM
 | EXP INC
 | EXP DEC
 | INC EXP
 | DEC EXP
 ;
 
Z: '='
 | '<'
 | '>'
 | LE
 | GE
 ;

%%

void yyerror(const char* s) {
	fprintf(stderr, "Invalid!\n");
	exit(1);
}

int main() {
	yyparse();
	printf("Number of nested FOR's are: %d\n", cnt);
	return 0;
}
