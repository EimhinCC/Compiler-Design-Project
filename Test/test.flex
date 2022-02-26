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
    System.out.print("Tokens: ");
    for(int i=0; i<tokens.size();i++){
        System.out.print(tokens.get(i) + ", ");
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
