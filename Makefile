EXPENDABLES = fib fib_omp
CC = cc
CFLAGS = 

fib: fib.c
	$(CC) $(CFLAGS) $< -o $@

fib_omp: fib.c
	$(CC) $(CFLAGS) -fopenmp $< -o $@

vector_add: vector_add.c
	$(CC) $(CFLAGS) -lm $< -o $@

.PHONY: clean
clean:
	/bin/rm -f $(EXPENDABLES)
