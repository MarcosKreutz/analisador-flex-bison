%{
#include <stdio.h>
#include <stdlib.h>


int totalErros = 0;
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

"elgio"     { printf("Linha %d: Palavra Reservada: %s\n", yylineno, yytext); }
"."         { printf("Linha %d: Fim de Comando: %s\n", yylineno, yytext); }



"numero"    { printf("Linha %d: Palavra Reservada: %s\n", yylineno, yytext); }
"NADA"      { printf("Linha %d: Constante Zero: %s\n", yylineno, yytext); }
"NEG"       { printf("Linha %d: Operador Negativo: %s\n", yylineno, yytext); }
"EXP"       { printf("Linha %d: Operador: %s\n", yylineno, yytext); }

"enquanto"  { printf("Linha %d: Palavra Reservada: %s\n", yylineno, yytext); }
"se"        { printf("Linha %d: Palavra Reservada: %s\n", yylineno, yytext); }
"entao"     { printf("Linha %d: Palavra Reservada: %s\n", yylineno, yytext); }
"senao"     { printf("Linha %d: Palavra Reservada: %s\n", yylineno, yytext); }
"para"      { printf("Linha %d: Palavra Reservada: %s\n", yylineno, yytext); }
"inicio"    { printf("Linha %d: Palavra Reservada: %s\n", yylineno, yytext); }
"fim"       { printf("Linha %d: Palavra Reservada: %s\n", yylineno, yytext); }

"maior"     { printf("Linha %d: Operador Relacional: %s\n", yylineno, yytext); }
"menor"     { printf("Linha %d: Operador Relacional: %s\n", yylineno, yytext); }
"igual"     { printf("Linha %d: Operador Relacional: %s\n", yylineno, yytext); }
"diferente" { printf("Linha %d: Operador Relacional: %s\n", yylineno, yytext); }
"migual"    { printf("Linha %d: Operador Relacional: %s\n", yylineno, yytext); }
"Migual"    { printf("Linha %d: Operador Relacional: %s\n", yylineno, yytext); }

"="         { printf("Linha %d: Operador Atribuicao: %s\n", yylineno, yytext); }
"+"         { printf("Linha %d: Operador: %s\n", yylineno, yytext); }
"-"         { printf("Linha %d: Operador: %s\n", yylineno, yytext); }
"x"         { printf("Linha %d: Operador: %s\n", yylineno, yytext); }
"/"         { printf("Linha %d: Operador: %s\n", yylineno, yytext); }
"%"         { printf("Linha %d: Operador: %s\n", yylineno, yytext); }

"("         { printf("Linha %d: Abre Parentese: %s\n", yylineno, yytext); }
")"         { printf("Linha %d: Fecha Parentese: %s\n", yylineno, yytext); }
","         { printf("Linha %d: Virgula: %s\n", yylineno, yytext); }

{NUMERO_INTEIRO} { printf("Linha %d: Numero Inteiro: %s\n", yylineno, yytext); }


{FUNC_VALIDA} {
    printf("Linha %d: Nome de Funcao: %s\n", yylineno, yytext);
}


{ID_VALIDO} {
    printf("Linha %d: Identificador: %s\n", yylineno, yytext);
}


{LETRA_MAI}{LETRA}[A-Za-z0-9_]+ {
    printf("Linha %d: [ERRO] Identificador malformado: %s\n", yylineno, yytext);
    totalErros++;
}


{LETRA_MAI} {
    printf("Linha %d: [ERRO] Identificador malformado: %s\n", yylineno, yytext);
    totalErros++;
}


_{LETRA}{LETRA}[A-Za-z0-9_]* {
    printf("Linha %d: [ERRO] Nome de funcao malformado: %s\n", yylineno, yytext);
    totalErros++;
}


[ \t\r\n]+  { /* ignora */ }

"*"[^\n]* { /* comentario de linha - ignora */ }

[a-z][a-zA-Z0-9_]* {
                printf("Linha %d: [ERRO LEXICO] Token invalido: %s\n", yylineno, yytext);
                totalErros++;
            }

.           {
                printf("Linha %d: [ERRO LEXICO] Caractere invalido: %s\n", yylineno, yytext);
                totalErros++;
            }

%%


int main(int argc, char **argv) {
    printf("--- ANALISADOR ELGOL ATIVO ---\n\n");

    yylex();

    printf("\n--- ANALISE FINALIZADA ---");
    printf("\nErros encontrados: %d\n", totalErros);

    return (totalErros > 0) ? 1 : 0;
}
