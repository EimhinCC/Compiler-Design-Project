/* Lexical analisis */

/*** Definition Section ***/
import java.io.*;

class Token {
    String text;
    Token(String t) {
        text = t;
    }
}

%%

%type Token

%class Lexer

%scanerror LexicalException

%unicode

Digit = [0-9]
Alpha = [a-zA-Z]
WhiteSp  = [\040\ n]

%%
/*** Rule Section***/
%%
{Digit}+ {
    return new Token(yytext());
}
{WhiteSp}+ {
    //function
}
. {
    throw new Error ("Illegal character <" + yytext() + ">");
}


/*** Code Section***/
public static void main (String argv[]) throws IOException {
	Yylex yy = new Yylex(System.in);
    Yytoken t;
    while((t = yy.yylex()) != null)
	    System.out.println(t);
}