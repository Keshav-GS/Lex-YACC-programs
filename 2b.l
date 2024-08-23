%{
#include "y.tab.h"
extern int yylval;
%}

%%

[0-9]+ {yylval = atoi(yytext); return NUM;};
[+] return '+';
[-] return '-';
[*] return '*';
[/] return '/';
. return yytext[0];
\n return 0;

%%

int yywrap() {
	return 1;
}

