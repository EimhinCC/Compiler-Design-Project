%{

#include <string.h>
#include <stdbool.h>

int yylex();
int yyerror(char *s);

%}

%union {
    int num;
    char sym;
    char word[99]; 
    bool tf;
}

%token Int Bool String Void SemiC EQU PLUS SUB MUL DIV AND OR MOD NOT Printf If Then Else For Return OpenB CloseB COpenB CCloseB Comma

%token <word> Word
%token <num> IntContent
%token <word> StringContent
%token <tf> BoolContent
%token <sym> Compare
%type <num> ReturnType
%type <word> Type
%type <num> Function
%type <num> Parameter
%type <num> Code
%token <tf> nExp
%token <tf> aExp
%token <tf> oExp

/* rules */
%%

input: 
Function 
| input input
;

Function:
ReturnType Word OpenB Parameter CloseB COpenB Code CCloseB
;

Parameter:
Type {$$ = 1}
|   Parameter Comma Parameter 
;

Code:
Type SemiC {$$ = 1}
| Word {$$ = 1}
;

Type:
    String Word {$$ = $2;}
|   Int Word {$$ = $2;}
|   Bool Word {$$ = $2;}
;

ReturnType:
Int {$$ = 1}
|   Bool {$$ = 2}
|   String {$$ = 3}
|   Void {$$ = 4}      
;

nExp:
NOT aExp {$$ = !$1;}
|   aExp
;

aExp:
aExp AND BoolContent
|   oExp
|   (nExp) AND aExp
;

oExp:
oExp OR BoolContent
|   BoolContent
|   (nExp) OR oExp
|   (nExp)




%%

int main() {
    yyparse();
    
    return 0;
}

int yyerror(char* s) {
    printf("Error: %s\n", s);
    return 0;
}