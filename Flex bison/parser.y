%{

#include <string.h>

int yylex();
int yyerrror(char *s);

%}

%union {
    int num;
    char sym;
    String string; 
    bool tf;
}

%token Int Bool String Void SemiC EQU PLUS SUB MUL DIV AND MOD Printf If Then Else For Return Word EOL ReturnType

%token <num> IntContent
%token <string> StringContent
%token <tf> BoolContent
%token <sym> Compare
%type <num> exp
%type <sym> Type
%type <sym> ReturnType

/* rules */
%%

input: 
Function

Function:
ReturnType Word

exp:
    IntContent { $$ = $1; }
|   exp PLUS exp { $$ = $1 + $3; }
|   exp SUB exp { $$ = $1 - $3; }
|   exp MUL exp { $$ = $1 * $3; }
|   exp DIV exp { $$ = $1 / $3; }
;

Type:
    String
|   Int
|   Bool 

ReturnType
Type
|   Void      



%%

int main() {
    yyparse();
    
    return 0;
}

yyerrror(char* s) {
    printf("Error: %s\n", s);
    return 0;
}