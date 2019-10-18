EXPENDABLES = fib fib_omp
CC = cc
CFLAGS = 

fib: fib.c
	$(CC) $(CFLAGS) $< -o $@

fib_omp: fib.c
	$(CC) $(CFLAGS) -fopenmp $< -o $@

malloc: malloc.c
	$(CC) $(CFLAGS) $< -o $@

.PHONY:
clean:
	/bin/rm -f $(EXPENDABLES)
