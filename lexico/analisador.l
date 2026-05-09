%{
#include <stdio.h>
#include <stdlib.h>

/* Aluno 01: Definições de Cabeçalho e Variáveis Globais */
int totalErros = 0;
%}

%option noyywrap
%option yylineno

/* Aluno 02 e 03: Definicoes de Regex (Macros). */
/* Aluno 03: Inteiros - Começa com 1-9, seguido de zero ou mais dígitos */
DIGITO_NAO_ZERO [1-9]
DIGITO          [0-9]
NUMERO_INTEIRO  {DIGITO_NAO_ZERO}{DIGITO}*

/* Aluno 02: Identificadores e funcoes */
LETRA_MAI       [A-Z]
LETRA_MIN       [a-z]
LETRA           [A-Za-z]
ID_VALIDO       {LETRA_MAI}{LETRA}{2,}{LETRA_MIN}
FUNC_VALIDA     _{ID_VALIDO}

%%

"elgio"     { printf("Linha %d: Palavra Reservada: %s\n", yylineno, yytext); }
"."         { printf("Linha %d: Fim de Comando: %s\n", yylineno, yytext); }

/* Aluno 03: Outras palavras reservadas, numeros e operadores */

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

{NUMERO_INTEIRO} { printf("Linha %d: Numero Inteiro: %s\n", yylineno, yytext); }

/* Aluno 02: Identificadores e nomes de funcoes. (Espaço reservado para seu colega) */
/* Funcao valida: _ + mesma regra do identificador */
{FUNC_VALIDA} {
    printf("Linha %d: Nome de Funcao: %s\n", yylineno, yytext);
}

/* Identificador valido: maiuscula, so letras, minuscula no fim, min 4 chars */
{ID_VALIDO} {
    printf("Linha %d: Identificador: %s\n", yylineno, yytext);
}

/* Identificador malformado: comeca com maiuscula mas viola alguma regra */
{LETRA_MAI}{LETRA}[A-Za-z0-9_]+ {
    printf("Linha %d: [ERRO] Identificador malformado: %s\n", yylineno, yytext);
    totalErros++;
}

/* Letra maiuscula isolada: nao forma identificador valido */
{LETRA_MAI} {
    printf("Linha %d: [ERRO] Identificador malformado: %s\n", yylineno, yytext);
    totalErros++;
}

/* Funcao malformada: comeca com _ mas viola as regras de identificador */
_{LETRA}{LETRA}[A-Za-z0-9_]* {
    printf("Linha %d: [ERRO] Nome de funcao malformado: %s\n", yylineno, yytext);
    totalErros++;
}

/* Aluno 01: Tratamento de espacos e erros basicos */
[ \t\r\n]+  { /* ignora */ }

"*"[^\n]* { /* comentário de linha - ignora */ }

.           {
                printf("Linha %d: [ERRO LEXICO] Caractere invalido: %s\n", yylineno, yytext);
                totalErros++;
            }

%%

/* Aluno 01: Função Principal (Main) */
int main(int argc, char **argv) {
    printf("--- ANALISADOR ELGOL ATIVO ---\n\n");

    yylex();

    printf("\n--- ANALISE FINALIZADA ---");
    printf("\nErros encontrados: %d\n", totalErros);

    return (totalErros > 0) ? 1 : 0;
}
