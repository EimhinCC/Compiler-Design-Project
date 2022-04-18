#Group 15 makefile

all:
	bison -d -t toy.y
	flex toy.l
	gcc lex.yy.c toy.tab.c
	./a
