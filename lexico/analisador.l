%{
#include <stdio.h>
#include <stdlib.h>

/* Aluno 01: Definições de Cabeçalho e Variáveis Globais */
int totalErros = 0;
%}

%option noyywrap
%option yylineno

/* Aluno 02 e 03: Definicoes de Regex (Macros). Aqui eles vão criar os apelidos para as Regex (Ex: DIGITO [0-9]) */

%%

"elgio"     { printf("Linha %d: Palavra Reservada: %s\n", yylineno, yytext); }
"."         { printf("Linha %d: Fim de Comando: %s\n", yylineno, yytext); }

/* Aluno 03: Outras palavras reservadas, numeros e operadores */


/* Aluno 02: Identificadores e nomes de funcoes. Aqui entra a lógica complexa do ID de 4 letras */


/* Aluno 01: Tratamento de espacos e erros basicos */
[ \t\r\n]+  { /* ignora */ }

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