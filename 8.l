%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%

"int"         { return INT; }
"main"        { return MAIN; }
"printf"      { return PRINTF; }
\"[^"]*\"       { yylval.str = strdup(yytext); return STRING; }
[a-zA-Z][a-zA-Z0-9]*          { yylval.id = strdup(yytext); return ID; }
[0-9]+     { yylval.num = atoi(yytext); return NUM; }
[ \t]          ; /* ignore whitespace */
. return yytext[0];
\n return 0;

%%

int yywrap() {
    return 1;
}
