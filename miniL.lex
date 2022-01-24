   /* cs152-miniL phase1 */
   
%{   
   /* write your C code here for definitions of variables and including headers */
   #include <stdio.h>
   int num_lines = 1;
   int num_cols = 1;
%}

   /* some common rules */
DIGIT     [0-9]
ID        [A-Za-z][A-Za-z0-9_]*[A-Za-z0-9]*
STARTD_ID  [0-9]+[A-Za-z_]+[A-Za-z0-9]*
STARTU_ID  [_]+[A-Za-z0-9_]*[A-Za-z0-9]*
END_ID    [A-Za-z][A-Za-z0-9_]*[_]+
%%
   /* specific lexer rules in regex */
" "            {++num_cols; }
"\t"           {num_cols += 4; }
"##".*         { /* DO NOTHING */ }           
\n             {++num_lines; num_cols = 0; }
"function"     {printf("FUNCTION\n"); num_cols += yyleng; }
"beginparams"  {printf("BEGIN_PARAMS\n"); num_cols += yyleng; }
"endparams"    {printf("END_PARAMS\n"); num_cols += yyleng; }
"beginlocals"  {printf("BEGIN_LOCALS\n"); num_cols += yyleng; }
"endlocals"    {printf("END_LOCALS\n"); num_cols += yyleng; }
"beginbody"    {printf("BEGIN_BODY\n"); num_cols += yyleng; }
"endbody"      {printf("END_BODY\n"); num_cols += yyleng; }
"integer"      {printf("INTEGER\n"); num_cols += yyleng; }
"array"        {printf("ARRAY\n"); num_cols += yyleng; }
"of"           {printf("OF\n"); num_cols += yyleng; }
"if"           {printf("IF\n"); num_cols += yyleng; }
"then"         {printf("THEN\n"); num_cols += yyleng; }
"endif"        {printf("ENDIF\n"); num_cols += yyleng; }
"else"         {printf("ELSE\n"); num_cols += yyleng; }
"while"        {printf("WHILE\n"); num_cols += yyleng; }
"do"           {printf("DO\n"); num_cols += yyleng; }
"beginloop"    {printf("BEGINLOOP\n"); num_cols += yyleng; }
"endloop"      {printf("ENDLOOP\n"); num_cols += yyleng; }
"continue"     {printf("CONTINUE\n"); num_cols += yyleng; }
"break"        {printf("BREAK\n"); num_cols += yyleng; }
"read"         {printf("READ\n"); num_cols += yyleng; }
"write"        {printf("WRITE\n"); num_cols += yyleng; }
"not"          {printf("NOT\n"); num_cols += yyleng; }
"true"         {printf("TRUE\n"); num_cols += yyleng; }
"false"        {printf("FALSE\n"); num_cols += yyleng; }
"return"       {printf("RETURN\n"); num_cols += yyleng; }

"-"            {printf("SUB\n"); num_cols += yyleng; }
"+"            {printf("ADD\n"); num_cols += yyleng; }
"*"            {printf("MULT\n"); num_cols += yyleng; }
"/"            {printf("DIV\n"); num_cols += yyleng; }
"%"            {printf("MOD\n"); num_cols += yyleng; }

"=="           {printf("EQ\n"); num_cols += yyleng; }
"<>"           {printf("NEQ\n"); num_cols += yyleng; }
"<"            {printf("LT\n"); num_cols += yyleng; }
">"            {printf("GT\n"); num_cols += yyleng; }
"<="           {printf("LTE\n"); num_cols += yyleng; }
">="           {printf("GTE\n"); num_cols += yyleng; }

";"            {printf("SEMICOLON\n"); num_cols += yyleng; }
":"            {printf("COLON\n"); num_cols += yyleng; }
","            {printf("COMMA\n"); num_cols += yyleng; }
"("            {printf("L_PAREN\n"); num_cols += yyleng; }
")"            {printf("R_PAREN\n"); num_cols += yyleng; }
"["            {printf("L_SQUARE_BRACKET\n"); num_cols += yyleng; }
"]"            {printf("R_SQUARE_BRACKET\n"); num_cols += yyleng; }
":="           {printf("ASSIGN\n"); num_cols += yyleng; }

{STARTD_ID}    {printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", num_lines, num_cols, yytext); exit(1); }
{STARTU_ID}    {printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", num_lines, num_cols, yytext); exit(1); }
{END_ID}       {printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", num_lines, num_cols, yytext); exit(1); }
{ID}           {printf("IDENT %s\n", yytext); num_cols += yyleng; }
{DIGIT}+       {printf("NUMBER %s\n", yytext); num_cols += yyleng; }

.              {++num_cols; printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", num_lines, num_cols, yytext); exit(1); }


%%
	/* C functions used in lexer */

int main(int argc, char ** argv)
{
   yylex();
}
