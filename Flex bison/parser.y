%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int yylex();
FILE *yyin;
int yyerror(char *s);

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
%token OpenB CloseB COpenB CCloseB Comma

%token <word> Word
%token <num> IntContent
%token <word> StringContent
%token <tf> BoolContent
%token <sym> Compare
%type <num> ReturnType
%type <num> Type
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
FuncDef
|   Struct 
|   input input
;

Struct:
"p"

FuncDef:
ReturnType Word OpenB Parameter CloseB COpenB Code CCloseB SemiC {$$ = $1}
;

FuncCall:
Word OpenB Parameter CloseB {$$ = 1}
| Printf CloseB StringContent CCloseB SemiC {$$ = 4}

Parameter:
Type {$$=1}
|   Parameter Comma Type {$$=1}
;

Code: 
Type SemiC {}
|   Word EQU Number {if(isDeclared($1, ints)){$$ = 1;} else {yyerror($1);}}
|   Word EQU StringContent {if(isDeclared($1, strs)){$$ = 2;} else {yyerror($1);}}
|   Word EQU nExp {if(isDeclared($1, bools)){$$ = 3;} else {yyerror($1);}}
|   Statement

Statement:
For {$$=1}

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
|   Number PLUS Number {$$ = $1 + $3;}
|   Number SUB Number {$$ = $1 - $3;}
|   Number MUL Number {$$ = $1 * $3;}
|   Number DIV Number {$$ = $1 / $3;}
|   Number MOD Number {$$ = $1 % $3;}


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