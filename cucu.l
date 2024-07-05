%{
#include<stdio.h>
#include<stdlib.h>
#include "cucu.tab.h"
void yyerror(char *s);

%}

%%    
main                {fprintf(yyout,"MAIN: %s\n",yytext);yylval.string=strdup(yytext);return MAIN;}
int|char[ ][*]      {yylval.string=strdup(yytext);  fprintf(yyout, "TYPE : %s\n", yytext); return TYPE;}                 {yylval.string=strdup(yytext);  fprintf(yyout, "TYPE : %s\n", yytext); return TYPE;}
[{]                 {fprintf(yyout,"LEFT_BRACE: %s\n",yytext);yylval.string=strdup(yytext);return LBRACE;}
[}]                 {fprintf(yyout,"RIGHT_BRACE: %s\n",yytext);yylval.string=strdup(yytext);return RBRACE;}
[\[]                {fprintf(yyout,"LEFT_SQ: %s\n",yytext);yylval.string=strdup(yytext);return LSQ;}
[\]]                {fprintf(yyout,"RIGHT_SQ: %s\n",yytext);yylval.string=strdup(yytext);return RSQ;}
while               {fprintf(yyout,"WHILE: %s\n",yytext);yylval.string=strdup(yytext);return WHILE;}
if                  {fprintf(yyout,"IF: %s\n",yytext);yylval.string=strdup(yytext);return IF;}
else                {fprintf(yyout,"ELSE: %s\n",yytext);yylval.string=strdup(yytext);return ELSE;}
"true"              {fprintf(yyout,"ELSE: %s\n",yytext);yylval.string=strdup(yytext);return TR;}
"false"             {fprintf(yyout,"ELSE: %s\n",yytext);yylval.string=strdup(yytext);return FL;}
[!][=]              {fprintf(yyout,"NOT_EQUAL: %s\n",yytext);yylval.string=strdup(yytext);return NE;}
["]                 {fprintf(yyout,"D_QUOTES: %s\n",yytext);yylval.string=strdup(yytext);return DQ;}
[,]                 {fprintf(yyout,"COMMA: %s\n",yytext);yylval.string=strdup(yytext);return COMMA;}
"return"            {fprintf(yyout,"RETURN: %s\n",yytext);yylval.string=strdup(yytext);return RETURN;}   
[&]                 {fprintf(yyout,"AND: %s\n",yytext);yylval.string=strdup(yytext);return AND;}
[<]                 {fprintf(yyout,"LESS_THAN: %s\n",yytext);yylval.string=strdup(yytext);return LT;}
[>]                 {fprintf(yyout,"GREATER_THAN: %s\n",yytext);yylval.string=strdup(yytext);return GT;}

[>][=]              {fprintf(yyout,"GT_EQUAL: %s\n",yytext);yylval.string=strdup(yytext);return GE;}
[<][=]              {fprintf(yyout,"LT_EQUAL: %s\n",yytext);yylval.string=strdup(yytext);return LE;}
[=]{2}              {fprintf(yyout,"EQUALS: %s\n",yytext);yylval.string=strdup(yytext);return EQ;}
[\d*\d]             {fprintf(yyout,"MULT: %s\n",yytext);yylval.string=strdup(yytext);return MULT;}
[*]{2}              {fprintf(yyout,"ASTS: %s\n",yytext);yylval.string=strdup(yytext);return DAST;}
[/]                 {fprintf(yyout,"DIVIDE: %s\n",yytext);yylval.string=strdup(yytext);return DIV;}
[%]                 {fprintf(yyout,"MOD: %s\n",yytext);yylval.string=strdup(yytext);return MOD;}
[;]                 {fprintf(yyout,"SEMICOL: %s\n",yytext);yylval.string=strdup(yytext);return SEMICOL;}
[|]                 {fprintf(yyout,"OR: %s\n",yytext);yylval.string=strdup(yytext);return OR;}
[-]                 {fprintf(yyout,"MINUS: %s\n",yytext);yylval.string=strdup(yytext);return MINUS;}
[+]                 {fprintf(yyout,"PLUS: %s\n",yytext);yylval.string=strdup(yytext);return PLUS;}
[=]                 {fprintf(yyout,"ASSIGN: %s\n",yytext);yylval.string=strdup(yytext);return ASSIGN;}
[(]                 {fprintf(yyout,"LEFT_PAREN: %s\n",yytext);yylval.string=strdup(yytext);return LPAREN;}
[)]                 {fprintf(yyout,"RIGHT_PAREN: %s\n",yytext);yylval.string=strdup(yytext);return RPAREN;}
\/\/.*              {;};
\/\*(.*\n)*.*\*\/   {;};

[a-zA-A_][a-zA-Z0-9_]*   { 
        yylval.string=strdup(yytext);
        fprintf(yyout,"ID : %s\n",yytext);
        return ID;
};

[0-9][0-9]* {
        yylval.number=atoi(yytext);
        fprintf(yyout,"NUM : %d\n",atoi(yytext));
        return NUM;
};          

[ \t\n]+       ; 
.                   {yyerror("");};
%%






