%{
#include <stdio.h>
int nc = 0;
%}

%%

"/*"[a-zA-Z0-9\t\n ]*"*/" {nc++;};
"//"[a-zA-Z0-9\t ]*\n {nc++; fprintf(yyout, "\n");};
. {fprintf(yyout, "%s", yytext);};

%%

int yywrap() {
	return 1;
}

int main() {
	yyin = fopen("3a_ip.txt", "r");
	yyout = fopen("3a_op.txt", "w");
	yylex();
	printf("The number of comments: %d\n", nc);
	fclose(yyin);
	fclose(yyout);
}
