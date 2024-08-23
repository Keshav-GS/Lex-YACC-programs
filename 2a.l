%option noyywrap

%{
int pi = 0;
int ni = 0;
int pf = 0;
int nf = 0;
%}

%%

[+]?[0-9]+ pi++;
[-][0-9]+ ni++;
[+]?[0-9]*[.][0-9]+ pf++;
[-][0-9]*[.][0-9]+ nf++;

. {/*ignore everything else*/};
\n return 0;

%%

int main() {
	yylex();
	printf("No.of positive integers: %d\n", pi);
	printf("No.of negative integers: %d\n", ni);
	printf("No.of positive fractions: %d\n", pf);
	printf("No.of negative fractions: %d\n", nf);
	return 0;
}

