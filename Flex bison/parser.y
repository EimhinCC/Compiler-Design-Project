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
char functions[100][15];
int l = 2;
functions[0] = "main"
functions[1] = "printf"


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
|   Word EQU Number {if(isDeclared($1, ints)){$$ = $1;} else {yyerror($1);}}
|   Word EQU StringContent {if(isDeclared($1, strs)){$$ = $1;} else {yyerror($1);}}
|   Word EQU nExp {if(isDeclared($1, bools)){$$ = $1;} else {yyerror($1);}}
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
    String Word {$$ = $2; strAdd($2);}
|   Int Word {$$ = $2; intAdd($2);}
|   Bool Word {$$ = $2; boolAdd($2);}
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
    j++;
    return;
}
void boolAdd(String varName) {
    strcpy(bools[k], varName);
    k++;
    return;
}
void funcAdd(String varName) {
    strcpy(functions[l], varName);
    l++;
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