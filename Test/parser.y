%{
    /* defintions*/
%}

%union {
    int num;
    char sym;
}

%token<num> Int
%token Bool
%token String
%token SemiC
%token EQU
%token StringContent
%token BoolContent
%token IntContent
%token Comment
%token Printf
%token If
%token Then
%token Else
%token For
%token Operator
%token Word
%token EOL

%type Struct
%type Function
%type Comparison
%type Type

/* rules */
%%

input: 
    Comment
|   Function
|   Struct


Struct:
    Struct {Word} {COpenB} {Declaration}+ {CCloseB}

%%

int main() {
    yyparse();
    
    return
}