%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char* s);
int cnt = 0;
extern FILE* yyin;
%}

%token TYPE IDENTIFIER NUM

%%

program: declarations;

declarations: declaration
	| declaration declarations
	//| /*empty*/ adding this line will cause RR conflict
	;
	
declaration: TYPE A B ';' ;

A: IDENTIFIER {cnt++;}
 | IDENTIFIER '[' ']' {cnt++;}
 | IDENTIFIER '[' NUM ']' {cnt++;}
 ;
 
B: ',' A B
 | /*empty*/
 ;

%%

void yyerror(const char* s) {
	fprintf(stderr, "Invalid!\n");
	exit(1);
}

int main() {
	yyin = fopen("5_input.txt", "r");
	yyparse();
	printf("Total number of variables: %d\n", cnt);
	return 0;
}


