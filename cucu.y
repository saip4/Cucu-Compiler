%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int yylex();

FILE *output_file;
void yyerror(const char *s) { fprintf(output_file, "ERROR: %s\n", s); }
int yywrap(void) { return 1; }
%}

%union {
	int number;
	char *string;
}

%token<string> ID IF ELSE WHILE LPAREN RPAREN ASSIGN SEMICOL PLUS MINUS MULT DIV DAST LBRACE RBRACE LSQ RSQ GE LE LT GT EQ NE AND OR TYPE COMMA RETURN MAIN DQ TR FL MOD
%token<number> NUM

%%

program : statement_list
	| 
	;

statement_list : statement
		   | statement_list statement
		   ;


statement : variable_declaration
	  | fun_declaration
	  | fun_definition
	  | fun_call
	  | if_statement
	  | while_statement
	  | expression_statement
	  | RETURN expression SEMICOL{fprintf(output_file, "\nReturn \n");}
	  ;

fun_definition : TYPE ID LPAREN fun_arguments RPAREN LBRACE fun_body RBRACE { fprintf(output_file, "Identifier-%s\n", $2); }
		   | TYPE MAIN LPAREN fun_arguments RPAREN LBRACE fun_body RBRACE { fprintf(output_file, "Identifier-main\n"); }
		   | TYPE ID LPAREN  RPAREN LBRACE fun_body RBRACE { fprintf(output_file, "Identifier-%s\n", $2); }
		   | TYPE MAIN LPAREN RPAREN LBRACE fun_body RBRACE {fprintf(output_file, "Identifier-main\n");}
		   ;

fun_declaration : TYPE ID LPAREN fun_arguments RPAREN SEMICOL { fprintf(output_file, "Variable- %s \n", $1); fprintf(output_file, "Function Declaration: %s\n", $2); }
		;

fun_call : ID LPAREN call_arguments RPAREN SEMICOL { fprintf(output_file, "Var- %s ", $1); fprintf(output_file, "\nFUN ends\nFUN-CALL\n"); }
		 | ID LPAREN RPAREN { fprintf(output_file, "Var- %s ", $1); fprintf(output_file, "\n%s-CALL\n",$1); }
	 ;

temp : ID LPAREN RPAREN { fprintf(output_file, "Var- %s ", $1); fprintf(output_file, "%s-CALL\n",$1); }
	 ;

call_arguments : expression
		   | expression COMMA call_arguments  
		   | expression EQ expression
		   ;

fun_body : statement
	 | fun_body statement
	 ;

fun_arguments : /* empty */
		  | TYPE ID { fprintf(output_file, "function argument: %s\n", $2); }
		  | TYPE ID {  fprintf(output_file, "function argument: %s\n", $2); $2 = $2 + 1; } COMMA fun_arguments
		  ;


variable_declaration : TYPE ID SEMICOL { fprintf(output_file, "local variable %s\n", $2); }
			 | TYPE ID ASSIGN expression SEMICOL { fprintf(output_file, ":= \nlocal variable: %s\n", $2); }
			 | TYPE ID LSQ expression RSQ SEMICOL { fprintf(output_file, "local variable: %s\n", $2); }
			 | TYPE ID LSQ expression RSQ ASSIGN expression SEMICOL { fprintf(output_file, ":= \nLocal variable- %s  ", $2); }
			 ;

if_statement : IF LPAREN expression RPAREN LBRACE fun_body RBRACE { fprintf(output_file, " Identifier-if\n"); }
		 | IF LPAREN expression RPAREN LBRACE fun_body RBRACE ELSE LBRACE fun_body RBRACE { fprintf(output_file, "  Identifier-if "); fprintf(output_file, " Identifier-else \n"); }
		 ;

while_statement : WHILE LPAREN expression RPAREN LBRACE fun_body RBRACE { fprintf(output_file, " Identifier-While\n"); }
		;

expression_statement : ID ASSIGN expression SEMICOL { fprintf(output_file, "Variable: %s  ", $1); }
			 | ID LSQ expression RSQ ASSIGN expression SEMICOL { fprintf(output_file, "Variable: %s  ", $1); }
			 | ID MINUS MINUS SEMICOL { fprintf(output_file, "Variable: %s  ", $1); }
			 | ID PLUS PLUS SEMICOL { fprintf(output_file, "Variable: %s  ", $1); }
			 | ID ASSIGN temp { fprintf(output_file, "Function called assigned :\n"); }
			 ;

expression : ID { fprintf(output_file, " variable- %s  ", $1); }
	   | NUM { fprintf(output_file, " Const: %d  ", $1); }
	   | expression PLUS expression { fprintf(output_file, "+ "); }
	   | expression MINUS expression { fprintf(output_file, "- "); }
	   | expression MULT expression { fprintf(output_file, "* ");}
	   | expression DIV expression { fprintf(output_file, "/ ");}
	   | LPAREN expression RPAREN
	   | ID LSQ expression RSQ { fprintf(output_file, "Array Access: %s\n", $1); }
	   | temp
	   ;

%%

int main(int argc[],char *argv[]){
	extern FILE *yyin,*yyout;
	yyin=fopen(argv[1],"r");
	yyout=fopen("Lexer.txt","w");
	output_file=fopen("Parser.txt","w");
	yyparse();

	return 0;
}
