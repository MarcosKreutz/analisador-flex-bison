%{
#include <stdio.h>
#include <stdlib.h>


extern int yylex();
extern int yylineno;
void yyerror(const char *s);
%}


%token ELGIO NUMERO NADA NEG EXP
%token ENQUANTO SE ENTAO SENAO PARA
%token INICIO FIM
%token MAIOR MENOR IGUAL DIFERENTE MIGUAL_MIN MIGUAL_MAI
%token ATRIB SOMA SUB MULT DIV MOD PONTO_FINAL
%token ABRE_P FECHA_P VIRGULA
%token IDENT IDENT_FUNC NUM_INTEIRO


%left SOMA SUB
%left MULT DIV MOD
%right EXP
%right NEG  /* O NEG tem precedencia alta para colar no numero */

%%

/* * GRAMATICA DO ELGOL
 * Aqui definimos como as "frases" sao formadas.
 */

programa:
    comandos
    ;

comandos:
    comando comandos
    | /* vazio (permite que o programa termine ou tenha linhas vazias) */
    ;

comando:
    declaracao_variavel PONTO_FINAL
    | atribuicao PONTO_FINAL
    | condicional_se
    | laco_enquanto
    | declaracao_funcao
    | bloco
    ;


bloco:
    INICIO PONTO_FINAL comandos FIM PONTO_FINAL
    ;

declaracao_variavel:
    NUMERO IDENT
    ;

atribuicao:
    IDENT ATRIB expressao
    | ELGIO ATRIB expressao
    ;


expressao:
    NUM_INTEIRO
    | NADA
    | IDENT
    | NEG expressao
    | expressao SOMA expressao
    | expressao SUB expressao
    | expressao MULT expressao
    | expressao DIV expressao
    | expressao MOD expressao
    | expressao EXP expressao
    | chamada_funcao
    | ABRE_P expressao FECHA_P
    ;


chamada_funcao:
    IDENT_FUNC ABRE_P lista_parametros FECHA_P
    ;

lista_parametros:
    expressao resto_parametros
    | /* vazio (funcao sem parametros) */
    ;

resto_parametros:
    VIRGULA expressao resto_parametros
    | /* vazio */
    ;


condicional_se:
    SE expressao_relacional PONTO_FINAL ENTAO PONTO_FINAL bloco
    | SE expressao_relacional PONTO_FINAL ENTAO PONTO_FINAL bloco SENAO PONTO_FINAL bloco
    ;


laco_enquanto:
    ENQUANTO expressao_relacional PONTO_FINAL bloco
    ;


expressao_relacional:
    expressao MAIOR expressao
    | expressao MENOR expressao
    | expressao IGUAL expressao
    | expressao DIFERENTE expressao
    | expressao MIGUAL_MIN expressao
    | expressao MIGUAL_MAI expressao
    ;


declaracao_funcao:
    NUMERO IDENT_FUNC ABRE_P definicao_parametros FECHA_P PONTO_FINAL bloco
    ;

definicao_parametros:
    NUMERO IDENT resto_def_parametros
    | /* vazio */
    ;

resto_def_parametros:
    VIRGULA NUMERO IDENT resto_def_parametros
    | /* vazio */
    ;

%%

void yyerror(const char *s) {
    printf("Linha %d: [ERRO SINTATICO] %s\n", yylineno, s);
}

int main(int argc, char **argv) {
    printf("--- INICIANDO COMPILACAO ELGOL ---\n\n");
    
    if (yyparse() == 0) {
        printf("\n--- COMPILACAO BEM SUCEDIDA (0 ERROS) ---\n");
    } else {
        printf("\n--- FALHA NA COMPILACAO ---\n");
    }
    
    return 0;
}
