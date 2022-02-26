import java.util.*;
%%
%class search
%standalone
%line
%column
LineTerminator = \r|\n|\r\n
Numbers = \d+\.?\d*
Word = \s+(\s|\d)*
Alpha = [a-zA-Z]
Digit = [0-9]
WhiteSp  = [\040\ n]
InputCharacter = [^\r\n]
Comment = "//" {InputCharacter}* {LineTerminator}?

Type = {Int}|{Boolean}|{String}
Int = "int"
Boolean = "boolean"

String = "string"
StringContent = """ {InputCharacter} """
Void = "void"

Declaration = {Type} {Word}

EQU = "="

OpenB = "("
CloseB = ")"

ReturnType = {Type}|{Void}

Struct = "struct" {Word} {OpenB} {Declaration}+ {CloseB}



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
{Numbers} {tokens.add("NUMBER");}
{Word} {tokens.add("WORD");}
{EQU} {tokens.add("EQU");}
{StringContent} {tokens.add("STRING_CONTENT");}
{Declaration} {tokens.add("DECLARATION");}
{Comment} {tokens.add("COMMENT");}
{WhiteSp} {}
\n {}
. {}
