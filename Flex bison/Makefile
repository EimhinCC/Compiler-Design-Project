#Group 15 makefile

all:
	flex lexer.l
	bison -d -t parser.y
	gcc lex.yy.c parser.tab.c

exec:
	./a