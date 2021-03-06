%{
#include <stdio.h>
#include <string.h>

#include "y.tab.h"

void yyerror (char *s);
int yylex();

%}
%%

"print"				            	{return print;}
"exit"				   	        	{return exit_command;}
"Integer"              	        	{yylval.type_id = Integer; return Integer;}
"Float"                         	{yylval.type_id = Float; return Float;}
"Char"                          	{yylval.type_id = Character; return Character;}
"String"                        	{yylval.type_id = String; return String;}
"Bool"                          	{yylval.type_id = Bool; return Bool;}
"Define Type"                       {return DEFINE_TYPE;}
"Const"                         	{return Const;}
"<="                            	{return LEQ;}
">="                    	        {return GEQ;}
"&&"                    	        {return AND;}
"||"                    	        {return OR;}
"=="                    	        {return EQEQ;}

"="                             	{return EQUAL;}
"+"                             	{return PLUS;}
"-"                             	{return MINUS;}
"*"                             	{return PROD;}
"/"                             	{return DIV;}
"<"                             	{return LS;}
">"                             	{return GE;}

"if"                            	{return IF;}
"else"                  	        {return ELSE;}
"elif"                  	        {return ELIF;}
"fun"                   	        {return FUN;}
"return"                	        {return RETURN;}
"Eval"                              {return EVAL;}
"While"                             {return WHILE;}
"For"                               {return FOR;}

[#].*[#]                            {;}
[()<>]                  	        {return yytext[0];}
[a-zA-Z]+([a-zA-Z]*[_]*[0-9]*)*	    {strcpy(yylval.string, yytext); return IDENTIFIER;}
["][^\"]*["]                	    {strcpy(yylval.string, yytext + 1); yylval.string[strlen(yytext + 1) - 1] = '\0'; return String_Value;}
['].[']                 	        {yytext[2] = '\0'; strcpy(yylval.string, yytext + 1); return Character_Value;}
[0]|[-]?[1-9][0-9]*     	        {yylval.num = atoi(yytext); return number;}
[0]|[-]?[1-9][0-9]*\.[0-9]+         {yylval.num = atof(yytext); return number_r;}
[ \t]                  		        ;
[\n]                    	        {yylineno++;}
[-+=*/{};,\[\]]                     {return yytext[0];}
.                       	        {ECHO; yyerror ("unexpected character"); printf("%s\n", yytext);}

%%
int yywrap (void) {return 1;}