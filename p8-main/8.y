%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yylineno;

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s at line %d\n", s, yylineno);
    exit(1);
}

%}

%union {
    char* id;
    int num;
    char* str;
}

%token <id> ID
%token <num> NUM
%token <str> STRING
%token INT MAIN PRINTF ADD LPAREN RPAREN SEMI COMMA LBRACE RBRACE ASSIGN

%start program

%%

program:
    INT MAIN LPAREN RPAREN LBRACE stmt_list RBRACE
    {
        printf(".data\n");
        printf("    .LC0: .string \"Sum %%d\"\n");  
        printf(".text\n");
        printf("    .globl main\n");
        printf("main:\n");
    }
    ;

stmt_list:
    stmt
    | stmt_list stmt
    ;

stmt:
    INT ID ASSIGN NUM SEMI {
        printf("   movl $%d, %s\n", $4, $2); 
    }
    | ID ASSIGN ID ADD ID SEMI {
        printf("    movl %s, %%eax\n", $3);
        printf("    addl %s, %%eax\n", $5);
        printf("    movl %%eax, %s\n", $1);
    }
    | PRINTF LPAREN STRING COMMA ID RPAREN SEMI {
        printf("    movl %s, %%edi\n", $5);  // Load argument into %edi
        printf("    movl $.LC0, %%rsi\n");   // Address of format string into %rsi
        printf("    call printf\n");         // Call printf function
    }
    ;

%%

int main() {
    printf("Assembly code output:\n");
    yyparse();
    return 0;
}
