%code requires{
    #include "ast.h"
}

%{
    #include <cstdio>
    using namespace std;
    int yylex();
    extern int yylineno;
    void yyerror(const char * s){
        fprintf(stderr, "Line: %d, error: %s\n", yylineno, s);
    }

    #define YYERROR_VERBOSE 1
%}

%union{
    const char * string_t;
    int int_t;
    float float_t;
    Expr * expr_t;
    ExprList * expr_list;
}

%token EOL
%token ADD SUB MUL DIV WHILE DO DONE ELSE LET
%token<string_t> TK_ID
%token<float_t> FLOAT

%type<expr_t> EXPR FACTOR TERM REL
%type<expr_list> EXPRLIST

%%

START: EXPRLIST {
    list<Expr *>::iterator it = $1->begin();
    while(it != $1->end()){
        printf("result: %f \n", (*it)->evaluate());
        it++;
    }
}
    ;

EXPRLIST: REL EOL { $$ = new ExprList; $$->push_back($1); }
    | EXPRLIST REL EOL { $$ = $1; $$->push_back($2); }
    ;

REL: REL '>' EXPR { $$ = new GTExpr($1, $3); }
    | REL '<' EXPR { $$ = new LTExpr($1, $3); }
    | EXPR { $$ = $1; }
    ;

EXPR: EXPR ADD FACTOR { $$ = new AddExpr($1, $3); }
    | EXPR SUB FACTOR { $$ = new SubExpr($1, $3); }
    | FACTOR { $$ = $1; }
    ;

FACTOR: FACTOR MUL TERM { $$ = new MulExpr($1, $3); }
    | FACTOR DIV TERM { $$ = new DivExpr($1, $3); }
    | TERM { $$ = $1; }
    ;

TERM: FLOAT { $$ = new NumExpr($1); }
    ;

%%
