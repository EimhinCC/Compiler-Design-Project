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
%token PLUS

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

exp:
    IntContent { $$ = $1; }
|    exp PLUS exp { $$ = $1 + $3; }
|    exp SUB exp { $$ = $1 - $3; }
;

Comparison:
    exp GT exp { $$ = $1 > $3; }

Type:
    String
|   Int
|   Bool       


Struct:
    Struct Word COpenB Declaration CCloseB

%%

int main() {
    yyparse();
    
    return
}