EXPENDABLES = fib fib_omp vector_add
CC = cc
CFLAGS = 

fib: fib.c
	$(CC) $(CFLAGS) $< -o $@

fib_omp: fib.c
	$(CC) $(CFLAGS) -fopenmp $< -o $@

vector_add: vector_add.c
	$(CC) $(CFLAGS) $< -o $@ -lm

.PHONY: clean
clean:
	/bin/rm -f $(EXPENDABLES)
