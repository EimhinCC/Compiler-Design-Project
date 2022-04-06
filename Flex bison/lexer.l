%{

#include <string.h>
#include <stdbool.h>
#include "parser.tab.h"

void showError();
void maxNum();
%}

LineTerminator \r|\n|\r\n
Alpha [a-zA-Z]
Digit [0-9]
WhiteSp  [\040\ n]
InputCharacter [^\r\n]

Comment ("//"{InputCharacter}*{LineTerminator}?)

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

And "and"
Mod "mod"
Or "or"
Not "not"
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
Not "!"
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

{Int} {return(Int);}
{Bool} {return(Bool);}
{String} {return(String);}
{Void} {return(Void);}

{IntContent} {yylval.num = atoi(yytext); maxNum(atoi(yytext)); return(IntContent);}
{StringContent} {sscanf(yytext, "%s", yylval.word); return(StringContent);}
{BoolContent} {sscanf(yytext, "%d", yylval.tf); return(BoolContent);}

{EQU} {return(EQU);}
{Plus} {return(PLUS);}
{Sub} {return(SUB);}
{Mul} {return(MUL);}
{Div} {return(DIV);}
{And} {return(AND);}
{Or} {return(OR);}
{Mod} {return(MOD);}
{Not} {return(NOT);}

{OpenB} {return(OpenB)}
{CloseB} {return(CloseB)}
{COpenB} {return(COpenB)}
{CCloseB} {return(CCloseB)}

{Comment} {/* Skip comments */}
{Printf} {return(Printf);}
{If} {return(If);}
{Then} {return(Then);}
{Else} {return(Else);}
{For} {return(For);}
{Return} {return(Return);}
{Compare} {sscanf(yytext, "%s", yylval.sym); return(Compare);}
{Word} {sscanf(yytext, "%s", yylval.word);return(Word);}
{SemiC} {return(SemiC);}
{Comma} {return(Comma);}
{WhiteSp} {}
\n {/* Do nothing */}}
. {showError();}
%%

int yywrap(){}

int main() {
    printf("Enter a string: ");
    yylex();

    return 0;
}

void showError(){
    printf("Invalid input");
}
void maxNum(int num) {
    if(num > 32768 || num < -32768) {
        printf("Invalid number");
    }
}