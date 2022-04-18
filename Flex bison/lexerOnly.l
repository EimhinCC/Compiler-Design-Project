%{

#include <string.h>
#include <stdbool.h>

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

{Int} {printf("Int ");}
{Bool} {printf("Bool ");}
{String} {printf("String ");}
{Void} {printf("Void "); }
{Struct} {printf("Struct "); }
{IntContent} {printf("IntC "); }
{StringContent} {printf("StrC "); }
{BoolContent} {printf("BoolC ");}
{EQU} {printf("EQU ");}
{Plus} {printf("Plus ");}
{Sub} {printf("Sub ");}
{Mul} {printf("Mul ");}
{Div} {printf("Div ");}
{And} {printf("And ");}
{Or} {printf("Or ");}
{Mod} {printf("Mod ");}
{Not} {printf("Not ");}
"(" {printf("( ");}
{CloseB} {printf(") ");}
{COpenB} {printf("{ ");}
{CCloseB} {printf("} ");}
{Comment} {printf("Comment "); /* Skip comments */}
{Printf} {printf("Print ");}
{If} {printf("if ");}
{Then} {printf("Then ");}
{Else} {printf("Else ");}
{For} {printf("For ");}
{Return} {printf("Return ");}
{Compare} {printf("Compare ");}
{Word} {printf("Word ");}
{SemiC} {printf("; ");}
{Comma} {printf(", ");}
{WhiteSp} {}
\n {/* Do nothing */}
. {printf("ERROR ");showError();}
%%

int yywrap(){}

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




