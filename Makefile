EXPENDABLES = fib fib_omp vector_add vector_add_cuda
CC = cc
NVCC = nvcc
CFLAGS = 

fib: fib.c
	$(CC) $(CFLAGS) $< -o $@

fib_omp: fib.c
	$(CC) $(CFLAGS) -fopenmp $< -o $@

vector_add: vector_add.c
	$(CC) $(CFLAGS) $< -o $@ -lm

vector_add_cuda: vector_add.cu
	$(NVCC) $(CFLAGS) $< -o $@ -lm

.PHONY: clean
clean:
	/bin/rm -f $(EXPENDABLES)
