ToY:	ToY.l ToY.y ToY-funcs.c
	bison -d ToY.y
	flex -o ToY.lex.c ToY.l
	gcc -o $@ ToY.tab.c ToY.lex.c ToY-funcs.c
