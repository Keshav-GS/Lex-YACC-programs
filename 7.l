%{
#include "y.tab.h"
%}

%%

^"#include ".+[\n] return INCLUDE;
[ \t] {/*ignore space, tab*/};
[\n] {yylineno++;};
"int" return TYPE;
"float" return TYPE;
"char" return TYPE;
"void" return VOID;
"printf" return PRINTF;
"return" return RETURN;
"//".*[\n] {/*ignore single line comments*/};
"/*"(.|\n)*"*/" {/*ignore multi line comments*/};
[_a-zA-Z]+[_a-zA-Z0-9]* return IDENTIFIER;
"," return ',';
"(" return '(';
")" return ')';
"{" return '{';
"}" return '}';
"=" return '=';
[0-9]+ return NUM;
";" return ';';
[+\-*/] return BASIC_OP;
\"(\\.|[^\\"])*\" return STRING_LITERAL;
. return yytext[0];

%%

int yywrap() {
	return 1;
}
