EXPENDABLES = fib fib_omp
CC = cc
CFLAGS = -Wall

fib: fib.c
	$(CC) $(CFLAGS) $< -o $@

fib_omp: fib.c
	$(CC) $(CFLAGS) -fopenmp $< -o $@
