%option noyywrap

%{
int w = 0;
int l = 0;
int c = 0;
int s = 0;
%}

%%

[a-zA-Z]+ {w++; c += yyleng;};
[.] l++;
[ \t] s += (yytext[0] == '\t')? 3: 1;
\n return 0;

%%

int main() {
	printf("Enter string: ");
	yylex();
	printf("No.of words = %d\nNo.of lines = %d\nNo.of characters = %d\nNo.of whitespaces = %d\n", w, l, c, s);
}
