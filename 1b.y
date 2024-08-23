%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(const char* s);
int yylex(void);
%}

%start S

%%

S: X Y;
X: 'a' X 'b'
 | /*empty*/
 ;
Y: 'b' Y 'c'
 | /*empty*/
 ;

%%

void yyerror(const char* s) {
	fprintf(stderr, "Invalid!\n");
	exit(1);
}

int main() {
	if(yyparse() == 0) printf("Valid!\n");
	return 0;
}
	
	
	
