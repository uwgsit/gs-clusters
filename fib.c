// Based on IWOMP 2010 tutorial (URL no longer available)

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <omp.h>
#include <getopt.h>
#include <errno.h>
#include <string.h>

unsigned long int fib(unsigned long int);
void usage();

int main(int argc,char **argv) {
    int c;
    unsigned long int n = 0;
    unsigned long int fib_n;

    while((c = getopt(argc,argv,"n:")) != -1) {
        switch(c) {
            case 'n':
                errno = 0;
                n = (unsigned long int)strtoul(optarg, (char **)NULL, 10);
                if(errno) {
                    fprintf(stderr,"Invalid input %s: %s\n",optarg,strerror(errno));
                    usage();
                    exit(EXIT_FAILURE);
                }
                break;
            case '?':
                usage();
                exit(EXIT_FAILURE);
                break;
            default:
                usage();
                abort();
                break;
        }
    }

    if(n < 1) {
        fprintf(stderr,"Supply number of Fibonaccis to calculated\n");
        usage();
        exit(EXIT_FAILURE);
    }

#pragma omp parallel
    {
#pragma omp single nowait
        {
            fib_n = fib(n);
        }
    }

    printf("%lu\n",fib_n);

    exit(EXIT_SUCCESS);
}

void usage() {
    fprintf(stderr,"fib -n <fib-number>\n");
    fprintf(stderr,"Calculates the first n Fibonacci numbers\n");
}

unsigned long int fib(unsigned long int n) {
    unsigned long int local_n,n1,n2;
    if(n < 2) {
        return n;
    }

    // Execute serially for the bottom part of the sequence to avoid spawning too many threads
    if(n < 20) {
        return fib(n-1) + fib(n-2);
    }
    else {
#pragma omp task shared(n1)
        n1 = fib(n-1);
#pragma omp task shared(n2)
        n2 = fib(n-2);
#pragma omp taskwait
        local_n = n1 + n2;

        return local_n;
    }
}
