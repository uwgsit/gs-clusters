// From EuroCC tutorial: https://enccs.github.io/OpenACC-CUDA-beginners/1.02_openacc-introduction/

#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <errno.h>
#include <string.h>
#include <math.h>
#ifdef _OPENACC
#include <openacc.h>
#endif

void usage();

int main(int argc,char **argv) {
    int c;
    unsigned long int n,i;
    double *vecA,*vecB,*vecC,sum;

    n = i = 0;

    while((c = getopt(argc,argv,"n:")) != -1) {
        switch(c) {
            case 'n':
                errno = 0;
                n = (unsigned long int)strtoul(optarg, (char**)NULL, 10);
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

    if((vecA = malloc(sizeof(double)*n)) == NULL) {
        perror("vecA malloc");
        exit(EXIT_FAILURE);
    }
    if((vecB = malloc(sizeof(double)*n)) == NULL) {
        perror("vecB malloc");
        exit(EXIT_FAILURE);
    }
    if((vecC = malloc(sizeof(double)*n)) == NULL) {
        perror("vecC malloc");
        exit(EXIT_FAILURE);
    }

    for(i=0;i<n;i++) {
        vecA[i] = 1.0 / ((double) (n - i));
        vecB[i] = pow(vecA[i],2);
    }

    for(i=0;i<n;i++) {
        vecC[i] = vecA[i] + vecB[i];
    }

    sum = 0,0;
    for(i=0;i<n;i++) {
        sum += vecC[i];
    }

    printf("Sum: %18.16f\n", sum);

    exit(EXIT_SUCCESS);
}

void usage() {
    fprintf(stderr,"vector-add -n <vector-size>\n");
    fprintf(stderr,"Initializes two vectors, adds them\n");
}
