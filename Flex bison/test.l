%{
int count = 0;
%}



%%
{Alpha} {printf("%s capital letter\n", yytext);
	count++;}
.	 {printf("%s not a capital letter\n", yytext);}
\n {return 0;}
%%

/*** Code Section prints the number of
capital letter present in the given input***/
int yywrap(){}
int main(){

 FILE *fp;
 char filename[50];
 printf("Enter the filename: \n");
 scanf("%s",filename);
 fp = fopen(filename,"r");
 yyin = fp;

yylex();
printf("\nNumber of Capital letters "
	"in the given input - %d\n", count);

return 0;
}