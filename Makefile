all: snake

snake:	snake.o
	ld -o snake snake.o

snake.o: snake.asm unistd.asm
	nasm -f elf snake.asm

clean:
	-rm snake snake.o
