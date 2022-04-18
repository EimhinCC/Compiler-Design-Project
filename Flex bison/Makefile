#Group 15 makefile

all:
	flex ToY.l
	bison -d -t ToY.y
	gcc lex.yy.c parser.tab.c
	./a
