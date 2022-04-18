%{

#include <string.h>
#include <stdbool.h>
#include "toy.tab.h"

int valid = 1;

void showError(){
    printf("Invalid input");
    valid = 0;
    return;
}
void maxNum(int num) {
    if(num > 32768 || num < -32768) {
        printf("Invalid number");
    }
}


%}

LineTerminator \r|\n|\r\n
Alpha [a-zA-Z]
Digit [0-9]
WhiteSp  [\040\ n]
InputCharacter [! #-~]

Comment ("//"{InputCharacter}*{LineTerminator})|("##"{InputCharacter}*{LineTerminator})

If "if"
Then "then"
Else "else"
For "for"
Return "return"

Int "int"
IntContent "-"?{Digit}+
Bool "bool"
True "true"
False "false"
BoolContent ({True}|{False})
String "string"
Quotes [\042]
StringContent ({Quotes}{InputCharacter}*{Quotes})

Printf "printf"
Void "void"
Struct "struct"

And "and"
Mod "mod"
Or "or"
OpenB "("
CloseB ")"
COpenB "{"
CCloseB "}"
SemiC ";"
Less "<"
Greater ">"
EQUIV "=="
LessEQU ({Less}{EQU})
GreaterEQU ({Greater}{EQU})
Not "!"|"not"
NotEQU "!"{EQU}
EQU "="
Plus "+"
Sub "-"
Mul "*"
Div "/"
Dot "\."
Comma ","
Compare ({Less}|{Greater}|{LessEQU}|{GreaterEQU}|{EQUIV}|{NotEQU})
IdentifierCharacter ({Alpha}|{Digit})
Word ({Alpha}{IdentifierCharacter}*)

%%

{Int} {printf("Int "); return(Int);}
{Bool} {printf("Bool "); return(Bool);}
{String} {printf("String "); return(String);}
{Void} {printf("Void "); return(Void);}
{Struct} {printf("Struct "); return(Struct);}
{IntContent} {printf("IntC ");yylval.num = atoi(yytext); maxNum(atoi(yytext)); return(IntContent);}
{StringContent} {printf("StrC ");yylval.word=yytext; return(StringContent);}
{BoolContent} {printf("BoolC ");yylval.word=yytext; return(BoolContent);}
{EQU} {printf("EQU ");yylval.sym=yytext[0];return(EQU);}
{Plus} {printf("Plus ");return(PLUS);}
{Sub} {printf("Sub ");return(SUB);}
{Mul} {printf("Mul ");return(MUL);}
{Div} {printf("Div ");return(DIV);}
{Dot} {printf("Dot ");return(DOT);}
{And} {printf("And ");return(AND);}
{Or} {printf("Or ");return(OR);}
{Mod} {printf("Mod ");return(MOD);}
{Not} {printf("Not ");return(NOT);}
{OpenB} {printf("( "); return(OpenB);}
{CloseB} {printf(") "); return(CloseB);}
{COpenB} {printf("{ "); return(COpenB);}
{CCloseB} {printf("} "); return(CCloseB);}
{Comment} {printf("Comment "); /* Skip comments */}
{Printf} {printf("Print ");return(Printf);}
{If} {printf("if ");return(If);}
{Then} {printf("Then ");return(Then);}
{Else} {printf("Else ");return(Else);}
{For} {printf("For ");return(For);}
{Return} {printf("Return ");return(Return);}
{Compare} {printf("Compare ");yylval.sym=yytext[0]; return(Compare);}
{Word} {printf("Word:");yylval.word=yytext;printf("%s ", yylval.word);return(Word);}
{SemiC} {printf("; ");return(SemiC);}
{Comma} {printf(", ");return(Comma);}
{WhiteSp} {}
\n {/* Do nothing */}
. {printf("ERROR ");showError();}
%%

int yywrap(){}
/*
int main() {
    FILE *fp;
   char filename[50];
    printf("Enter the filename: \n");
    scanf("%s",filename);
    fp = fopen(filename,"r");
    yyin = fp;

    yylex();
    if(valid) {
    printf("\nValid input END");
    }
    else {
        printf("Invalid input");
    }

    return 0;
}
*/



