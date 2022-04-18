%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int yylex();
FILE *yyin;
int yyerror(char *s);
int validParse = 0;

void intAdd(char *varName);
void strAdd(char *varName);
void boolAdd(char *varName);
void funcAdd(char *varName);
int isDeclared(char *varName, char array[100][15]);

char ints[100][15];
int i;
char strs[100][15];
int j;
char bools[100][15];
int k;
char functions[100][15];
int l;



%}

%union {
    int num;
    char sym;
    char * word; 
    bool tf;
}

%token Int Bool String Void SemiC EQU PLUS SUB MUL DIV AND OR MOD NOT Printf If Then Else For Return 
%token OpenB CloseB COpenB CCloseB Comma Struct

%token <word> Word
%token <num> IntContent
%token <word> StringContent
%token <tf> BoolContent
%token <sym> Compare
%type <num> ReturnType
%type <num> Type
%type <num> TypeList
%type <num> FuncDef
%type <num> FuncCall
%type <num> Parameter
%type <num> Code
%type <tf> nExp
%type <tf> aExp
%type <tf> oExp
%type <num> Statement
%type <num> IfStatement
%type <num> Number

/* rules */
%%

input: 
Struct Word COpenB TypeList CCloseB {validParse=1;}
|   FuncDef {validParse=1;}
|   input input {validParse=1;}
;

TypeList:
Type SemiC
|   TypeList Type SemiC {$$=1}

FuncDef:
ReturnType Word OpenB Parameter CloseB COpenB Code CCloseB SemiC {$$ = $1}
;

FuncCall:
Word OpenB Parameter CloseB SemiC{if(isDeclared($1, functions)){$$ = 1;} else {yyerror($1);}}
| Printf CloseB StringContent CCloseB SemiC {$$ = 1}

Parameter:
Type {$$=1}
|   Parameter Comma Type {$$=1}
;

Code: 
Type SemiC {}
|   FuncCall {}
|   Word EQU Number {if(isDeclared($1, ints)){$$ = 1;} else {yyerror($1);}}
|   Word EQU StringContent {if(isDeclared($1, strs)){$$ = 2;} else {yyerror($1);}}
|   Word EQU nExp {if(isDeclared($1, bools)){$$ = 3;} else {yyerror($1);}}
|   Statement

Statement:
For Condition COpenB Code CCloseB {$$=1}
|   IfStatement

IfStatement:
If Condition Then  COpenB Code CCloseB {$$ = 1}
|   IfStatement Else COpenB Code CCloseB {$$ = $1}

Condition:
OpenB nExp CloseB
|   OpenB Number Compare Number CloseB

Type:
    String Word {$$ = 1; strAdd($2);}
|   Int Word {$$ = 2; intAdd($2);}
|   Bool Word {$$ = 3; boolAdd($2);}
;

Number:
IntContent
|   Number PLUS IntContent {$$ = $1 + $3;}
|   Number SUB IntContent {$$ = $1 - $3;}
|   Number MUL IntContent {$$ = $1 * $3;}
|   Number DIV IntContent {$$ = $1 / $3;}
|   Number MOD IntContent {$$ = $1 % $3;}


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
oExp OR BoolContent {$$ = 1;}
|   BoolContent {$$ = $1;}
|   OpenB nExp CloseB OR oExp {$$ = $2|$5;}
|   OpenB nExp CloseB {$$ = $2;}
;



%%

int main() {

    i = 0;
    j = 0;
    k = 0;
    l = 2;
    strcpy(functions[0], "main");
    strcpy(functions[1], "printf");

    FILE *fp;
    char filename[50];
    printf("Enter the filename: \n");
    scanf("%s",filename);
    fp = fopen(filename,"r");
    yyin = fp;

    yyparse();
    if(validParse) {
    printf("\nValid input END");
    }
    else {
        printf("Invalid input");
    }

    
    return 0;
}

int yyerror(char* s) {
    printf("Error: %s\n", s);
    return 0;
}

void intAdd(char * varName) {
    strcpy(ints[i], varName);
    i++;
    return;
}
void strAdd(char * varName) {
    strcpy(strs[j], varName);
    j++;
    return;
}
void boolAdd(char * varName) {
    strcpy(bools[k], varName);
    k++;
    return;
}
void funcAdd(char * varName) {
    strcpy(functions[l], varName);
    l++;
    return;
}
int isDeclared(char * varName, char array[100][15]) {
    for(int i = 0; i<100; i++) {
        if (array[i]!= NULL) {
        if (strcmp(varName, array[i])){
            return 1;
        }
        }
    }
    return 0;
}