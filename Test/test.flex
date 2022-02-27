import java.util.*;
%%
%class compile
%standalone
%line
%column
LineTerminator = \r|\n|\r\n
Numbers = \d+\.?\d*
Alpha = [a-zA-Z]
Digit = [0-9]
WhiteSp  = [\040\ n]
InputCharacter = [^\r\n]
Comment = "//" {InputCharacter}* {LineTerminator}?

Type = {Int}|{Bool}|{String}

If = "if"

Then = "then"

Else = "else"

For = "for"

Return = "return"

Int = "int"
IntContent = {Digit}+

Bool = "bool"
True = "true"
False = "false"
BoolContent = {True}|{False}

String = "string"
Quotes = [\042]
StringContent = {Quotes} {InputCharacter}* {Quotes}

Printf = "printf"

Void = "void"

Declaration = {Type} {Word}

OpenB = "("
CloseB = ")"
COpenB = "{"
CCloseB = "}"
SemiC = ";"
Less = "<"
Greater = ">"
EQUIV = "=="
LessEQU = {Less} {EQU}
GreaterEQU = {Greater} {EQU}
Not = "!"
NotEQU = "!" {EQU}
EQU = "="
Plus = "+"
Minus= "-"
Dot = "\."

Compare = {Less} | {Greater} | {LessEQU} | {GreaterEQU} | {EQUIV} | {NotEQU}
Comparison = ({Word} | {Numbers}) {Compare} ({Word} | {Numbers})

Operator = {Plus} | {Minus}

ReturnType = {Type}|{Void}

Struct = "struct" {Word} {COpenB} {Declaration}+ {CCloseB}



IdentifierCharacter = {Alpha} | {Digit}
Word = {Alpha}{IdentifierCharacter}*

%{
 List<String> tokens = new ArrayList();
%}

%eof{
    boolean error = false;
    System.out.print("Tokens: ");
    for(int i=0; i<tokens.size();i++){
     system.out.print(token.get(i));
    }
        for(int i=0; i<tokens.size();i++){
        if(token.get(i)==COMMENT){}
        else if(token.get(i)==TYPE) {}
        else if(token.get(i)==WORD) {}
        else if(token.get(i)==PRINTF) {}
        else if(token.get(i)==STRUCT) {}
        else if(token.get(i)==THEN) {}
        else if(token.get(i)==IF) {}
        else if(token.get(i)==FOR) {}
        else {
            error = true;
            break;
            }
        if(error){
            system.out.print("Error");
        }
        else {
            system.out.print("Valid");
        }
    }
%eof}

%%
{Type} {tokens.add("TYPE");}
{SemiC} {tokens.add("SEMIC");}
{EQU} {tokens.add("EQU");}
{StringContent} {tokens.add("STRINGCONTENT");}
{BoolContent} {tokens.add("BOOLCONTENT");}
{IntContent} {tokens.add("INTCONTENT");}
{Declaration} {tokens.add("DECLARATION");}
{Comment} {tokens.add("COMMENT");}
{Struct} {tokens.add("STRUCT");}
{Printf} {tokens.add("PRINTF");}
{If} {tokens.add("IF");}
{Then} {tokens.add("THEN");}
{Else} {tokens.add("ELSE");}
{For} {tokens.add("FOR");}
{Comparison} {tokens.add("COMPARISON");}
{Operator} {tokens.add("OPERATOR");}
{Word} {tokens.add("WORD");}
{WhiteSp} {}
\n {}
. {}
