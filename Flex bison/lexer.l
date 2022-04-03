%{

#include <string.h>
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
Compare ({Less}|{Greater}|{LessEQU}|{GreaterEQU}|{EQUIV}|{NotEQU})
IdentifierCharacter ({Alpha}|{Digit})
Word ({Alpha}{IdentifierCharacter}*)

%%

{Int} {return(Int);}
{Bool} {return(Bool);}
{String} {return(String);}
{Void} {return(Void);}

{IntContent} {yylval.number = atoi(yytext); maxNum(atoi(yytext)); return(IntContent);}
{StringContent} {sscanf(yytext, "%s", yylval.string); return(StringContent);}
{BoolContent} {sscanf(yytext, "%d", yylval.tf); return(BoolContent);}

{EQU} {return(EQU);}
{Plus} {return(PLUS);}
{Sub} {return(SUB);}
{Mul} {return(MUL);}
{Div} {return(DIV);}
{And} {return(AND);}
{Or} {return(OR);}
{Mod} {return(MOD);}


{Comment} {/* Skip comments */}
{Printf} {return(printf);}
{If} {return(If);}
{Then} {return(Then);}
{Else} {return(Else);}
{For} {return(For);}
{Return} {return(Return);}
{Compare} {sscanf(yytext, "%s", yylval.sym); return(Compare);}
{Word} {sscanf(yytext, "%s", yylval.string);return("Word");}
{SemiC} {return(SemiC);}
{WhiteSp} {}
\n {return EOL;}
. {showError();}
%%

yywrap(){}

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