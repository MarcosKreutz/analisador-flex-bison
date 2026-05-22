%{
#include "sintatico.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

%option noyywrap
%option yylineno


DIGITO_NAO_ZERO [1-9]
DIGITO          [0-9]
NUMERO_INTEIRO  {DIGITO_NAO_ZERO}{DIGITO}*


LETRA_MAI       [A-Z]
LETRA_MIN       [a-z]
LETRA           [A-Za-z]
ID_VALIDO       {LETRA_MAI}{LETRA}{LETRA}+{LETRA_MIN}
FUNC_VALIDA     _{ID_VALIDO}

%%

"elgio"     { return ELGIO; }
"."         { return PONTO; }


"numero"    { return NUMERO_TIPO; }
"NADA"      { return NADA; }
"NEG"       { return NEG; }
"EXP"       { return EXP; }

"enquanto"  { return ENQUANTO; }
"se"        { return SE; }
"entao"     { return ENTAO; }
"senao"     { return SENAO; }
"para"      { return PARA; }
"inicio"    { return INICIO; }
"fim"       { return FIM; }

"maior"     { return MAIOR; }
"menor"     { return MENOR; }
"igual"     { return IGUAL; }
"diferente" { return DIFERENTE; }
"migual"    { return MIGUAL; }
"Migual"    { return MIGUAL_UP; }

"="         { return ATRIBUICAO; }
"+"         { return MAIS; }
"-"         { return MENOS; }
"x"         { return VEZES; }
"/"         { return DIVISAO; }
"%"         { return MODULO; }

"("         { return ABRE_PAR; }
")"         { return FECHA_PAR; }
","         { return VIRGULA; }

{NUMERO_INTEIRO} { return NUM; }


{FUNC_VALIDA} {
   return ID_FUNC;
}


{ID_VALIDO} {
    return ID;
}


{LETRA_MAI}{LETRA}[A-Za-z0-9_]+ {
    return ERRO_LEXICO;
}


{LETRA_MAI} {
    return ERRO_LEXICO;
}


_{LETRA}{LETRA}[A-Za-z0-9_]* {
    return ERRO_LEXICO;
}


[ \t\r\n]+  { /* ignora */ }

"*"[^\n]* { /* comentario de linha - ignora */ }

[a-z][a-zA-Z0-9_]* {
                return ERRO_LEXICO;
            }

.           {
                return ERRO_LEXICO;
            }

%%
