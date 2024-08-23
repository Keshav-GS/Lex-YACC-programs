%{
#include "y.tab.h"
%}

%%

"for" return FOR;
"(" return '(';
[a-zA-Z]+ return EXP; //EXP here means IDENTIFIER. Better to rename
[0-9]+ return NUM;
";" return ';';
"=" return '=';
">" return '>';
"<" return '<';
"<=" return LE;
">=" return GE;
"++" return INC;
"--" return DEC;
")" return ')';
"{" return '{';
"}" return '}';
\n return 0;
. {/*Ignore anything else*/};

%%

int yywrap() {
	return 1;
}


