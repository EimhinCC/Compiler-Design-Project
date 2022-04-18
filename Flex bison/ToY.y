%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int yylex();
FILE *yyin;
int yyerror(char *s);
int validParse = 1;

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

%token Int Bool String Void SemiC EQU PLUS SUB MUL DIV DOT AND OR MOD NOT Printf If Then Else For Return 
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
%type <num> ReturnStatem
%type <num> IfStatement
%type <num> Number

%left PLUS SUB MUL DIV
%right Then Else
%nonassoc Compare


/* rules */
%%

input: 
Struct Word COpenB TypeList CCloseB {}
|   FuncDef {}
|   input input {}
;

TypeList:
Type SemiC
|   TypeList Type SemiC {$$=1}
;

FuncDef:
ReturnType Word OpenB Parameter CloseB COpenB Code CCloseB {$$ = $1}   
;

FuncCall:
Word OpenB Parameter CloseB SemiC{isDeclared($1, functions);$$ = 1;}
| Printf OpenB StringContent CloseB SemiC {$$ = 1}
;

Parameter: {$$=1}
|   Type {$$=1}
|   Parameter Comma Parameter {$$=1}
;

Code: 
Type SemiC { $$ = $1; }
|   FuncCall { $$ = $1; }
|   Word EQU Number SemiC {isDeclared($1, ints); $$ = 1;}
|   Word EQU StringContent SemiC {isDeclared($1, strs);$$ = 2;}
|   Word EQU nExp SemiC {isDeclared($1, bools);$$ = 3;}
|   Statement {}
|   ReturnStatem {}
|   Code Code {}
;

ReturnStatem:
Return SemiC {}
|   Return Word SemiC {}
|   Return IntContent SemiC {}
|   Return StringContent SemiC {}
|   Return BoolContent SemiC {}

Statement:
For OpenB Word EQU Number SemiC Condition SemiC Word EQU Number SemiC CloseB COpenB Code CCloseB {}
|   IfStatement
;

IfStatement:
If OpenB Condition CloseB Then  COpenB Code CCloseB {$$ = 1}
|   IfStatement Else COpenB Code CCloseB {$$ = $1}
;

Condition:
Word {isDeclared($1, bools);}
|   nExp
;

Type:
    String Word {$$ = 1; strAdd($2);}
|   Int Word {$$ = 2; intAdd($2);}
|   Bool Word {$$ = 3; boolAdd($2);}
;

Number:
IntContent {$$=$1;}
|   Word {isDeclared($1, ints);}
|   Number PLUS IntContent {$$ = $1 + $3;}
|   Number SUB IntContent {$$ = $1 - $3;}
|   Number MUL IntContent {$$ = $1 * $3;}
|   Number DIV IntContent {$$ = $1 / $3;}
|   Number MOD IntContent {$$ = $1 % $3;}
;

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
|   aExp AND Number Compare Number {$$ = true}
|   aExp AND Word Compare Number {$$ = true}
|   aExp AND Word Compare Word {$$ = true}
|   oExp {$$ = $1;}
|   OpenB nExp CloseB AND aExp {$$ = $2 && $5;}
;

oExp:
oExp OR BoolContent {$$ = 1;}
|   oExp OR Number Compare Number {$$ = true}
|   oExp OR Word Compare Number {$$ = true}
|   oExp OR Word Compare Word {$$ = true}
|   BoolContent {$$ = $1;}
|   Number Compare Number {$$ = true}
|   Word Compare Number {isDeclared($1, ints);$$ = true}
|   Word Compare Word {isDeclared($1, ints); isDeclared($3, ints);$$ = true}
|   OpenB nExp CloseB OR oExp {$$ = $2|$5;}
|   OpenB nExp CloseB {$$ = $2;}
;



%%

int main() {

    i = 0;
    j = 0;
    k = 0;
    l = 2;

    for (int i = 0; i < 100; i++) {
        ints[i][0] = '0';
        strs[i][0] = '0';
        bools[i][0] = '0';
    }   

    strcpy(functions[0], "main");
    strcpy(functions[1], "printf");

    FILE *fp;
    char filename[50];
    printf("Enter the filename: \n");
    scanf("%s",filename);
    fp = fopen(filename,"r");
    yyin = fp;

    yyparse();
    for(int i = 0; i<100; i++) {
        if (strcmp(ints[i],"0")) {
            printf(" ||| ");
            printf(ints[i]);
            printf(" ||| ");
        }
        else {
            break;
        }
    }
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
    validParse=0;
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
    printf(varName);
    int a = i;
    while(a > 0) {
        if (strstr(varName, array[a-1])){
            printf(array[i]);
            return 1;
        }
        a--;
    }
    validParse = 0;
    return 0;
}