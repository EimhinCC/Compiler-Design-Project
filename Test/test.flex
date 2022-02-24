import java.util.*;
%%
%class search
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

%{
 List<String> numbers = new ArrayList();
 List<String> tokens = new ArrayList();
%}

%eof{
    System.out.print("Numbers: ");
    for(int i=0; i<numbers.size();i++){
        System.out.print(numbers.get(i) + ", ");
    }
%eof}

%%
{Numbers} {numbers.add(yytext()); tokens.add("NUMBER");}
{Comment} {}
{WhiteSp} {}
\n {}
. {}
