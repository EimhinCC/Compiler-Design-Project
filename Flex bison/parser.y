%{

#include <string.h>
#include <stdbool.h>

int yylex();
int yyerror(char *s);
char ints[100][15];
int i = 0;
char strs[100][15];
int j = 0;
char bools[100][15];
int k = 0;


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
%type <tf> nExp
%type <tf> aExp
%type <tf> oExp
%type <num> Statement
%type <num> number

/* rules */
%%

input: 
Function
|   Struct 
|   input input
;

Function:
ReturnType Word OpenB Parameter CloseB COpenB Code CCloseB SemiC {$$ = $1}
|   Printf CloseB StringContent CCloseB SemiC {$$ = 4}
;

Parameter:
Type
|   Parameter Comma Parameter 
;

Code: 
Type SemiC {}
|   Word EQU number {if(isDeclared($1, ints)){$$ = $1;} else {yyerror($1);}}
|   Word EQU StringContent {if(isDeclared($1, strs)){$$ = $1;} else {yyerror($1);}}
|   Word EQU nExp {if(isDeclared($1, bools)){$$ = $1;} else {yyerror($1);}}
|   Statement

Statement:
IfStatement
|   For
|

IfStatement:
If Condition Then  COpenB Code CCloseB {$$ = $2}
|   IfStatement Else COpenB Code CCloseB {$$ = $1}

Condition:
OpenB nExp CloseB
OpenB Value Compare Value CloseB


Code:
Type SemiC {$$ = 1;}
| Word {$$ = 1;}
;

Type:
    String Word {$$ = $2; strAdd($2);}
|   Int Word {$$ = $2; intAdd($2);}
|   Bool Word {$$ = $2; boolAdd($2);}
;

number:
IntContent
|   number PLUS number {$$ = $1 + $3;}
|   number SUB number {$$ = $1 - $3;}
|   number MUL number {$$ = $1 * $3;}
|   number DIV number {$$ = $1 / $3;}
|   number MOD number {$$ = $1 % $3;}


ReturnType:
Int {$$ = 1;}
|   Bool {$$ = 2;}
|   String {$$ = 3;}
|   Void {$$ = 4;}      
;

nExp:
NOT aExp {$$ = !$2;}
|   aExp {$$ = $1;}
;

aExp:
aExp AND BoolContent {$$= $1 && $3;}
|   oExp {$$ = $1;}
|   OpenB nExp CloseB AND aExp {$$ = $2 && $5;}
;

oExp:
oExp OR BoolContent {$$ = $1 || $$3;}
|   BoolContent {$$ = $1;}
|   OpenB nExp CloseB OR oExp {$$ = $2|$5;}
|   OpenB nExp CloseB {$$ = $2;}




%%

int main() {
    yyparse();
    
    return 0;
}

int yyerror(char* s) {
    printf("Error: %s\n", s);
    return 0;
}

void intAdd(String varName) {
    strcpy(ints[i], varName);
    i++;
    return;
}
void strAdd(String varName) {
    strcpy(strs[j], varName);
    i++;
    return;
}
void boolAdd(String varName) {
    strcpy(bools[k], varName);
    i++;
    return;
}

int isDeclared(String varName, char array []) {
    for(int i = 0; i<100; i++) {
        if (strcmp(varName, array[i])){
            return 1;
        }
    }
    return 0;
}