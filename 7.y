%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char* s);
extern FILE* yyin;
extern int yylineno;
extern char* yytext;
%}

%token INCLUDE TYPE VOID IDENTIFIER BASIC_OP NUM PRINTF STRING_LITERAL RETURN
%left BASIC_OP '=' //if this line is omitted, causes 4 SR conflicts

%%

program: headers definitions
	;
	
headers: headers header
	| header
	;
	
header: INCLUDE
	;
	
definitions: definitions definition
	| definition
	;

definition: TYPE IDENTIFIER '(' arg_list ')' '{' body RETURN expr ';' '}'
	| TYPE IDENTIFIER '(' arg_list ')' '{' RETURN expr ';' '}'
	| VOID IDENTIFIER '(' arg_list ')' '{' body '}'
	;
	
arg_list: arg_list ',' TYPE IDENTIFIER
	| TYPE IDENTIFIER
	| /*empty*/
	;

identifier_list: identifier_list ',' IDENTIFIER 
	| IDENTIFIER
	;
	
body: body statement
	| statement
	;
	
statement: declaration
	| assignment
	| PRINTF '(' STRING_LITERAL ',' identifier_list ')' ';'
	;
	
declaration: TYPE identifier_list ';'
	;

assignment: IDENTIFIER '=' expr ';'
	;
 
expr: expr BASIC_OP expr
	| expr '=' expr
	| IDENTIFIER
	| NUM
	;
	
%%

void yyerror(const char* s) {
	fprintf(stderr, "%d: %s\n %s\n", yylineno, s, yytext);
}

int main() {
	yyin = fopen("7_input.txt","r");
	if(yyparse() == 0) printf("Parsing successful!\n");
	else printf("Parsing unsuccessful\n");
	fclose(yyin);
	return 0;
}
