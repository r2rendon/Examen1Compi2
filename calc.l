%option noyywrap
%option yylineno

%{
    #include <stdio.h>
    #include "tokens.h"
%}

NUM [0-9]+
ID [a-zA-Z]({NUM}|[a-zA-Z_0-9]|_)*

%%
"+" { return ADD; }
"=" { return '='; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"(" { return '('; }
")" { return ')'; }
"," { return ','; }
";" { return ';'; }
">" { return '>'; }
"<" { return '<'; }
"let" { return LET; }
"while" { return WHILE; }
"do" { return DO; }
"done" { return DONE; }
[\n] { return EOL; }
[ \t] { /* ignorar */ }
{NUM}+"."{NUM}+ {yylval.float_t= atof(yytext); return (FLOAT);}
{NUM}+ {yylval.float_t = atof(yytext); return (FLOAT);}
ID { yylval.string_t = strdup(yytext); return TK_ID; }
. { printf("\ninvalido %c\n", yytext[0]); }
%%