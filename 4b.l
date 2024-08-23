%{
#include "y.tab.h"
%}

%%

"if" return IF;
"(" return '(';
")" return ')';
"{" return '{';
"}" return '}';
[0-9]+ return NUM;
[a-zA-Z]+ return EXP; 
\n return 0;
. {/*ignore everything else*/};

%%

int yywrap() {
	return 1;
}
