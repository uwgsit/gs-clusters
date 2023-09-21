#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <errno.h>
#include <string.h>
#include <math.h>

void usage();
void vector_add(double *,double *,double *,const unsigned long int);

int main(int argc,char **argv) {
    int c;
    unsigned long int i,n;
    double *vecA,*vecB,*vecC,sum;

    n = 0;

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

    if((vecA = (double *)malloc(sizeof(double)*n)) == NULL) {
        perror("vecA malloc");
        exit(EXIT_FAILURE);
    }
    if((vecB = (double *)malloc(sizeof(double)*n)) == NULL) {
        perror("vecB malloc");
        exit(EXIT_FAILURE);
    }

    if((vecC = (double *)malloc(sizeof(double)*n)) == NULL) {
        perror("vecC malloc");
        exit(EXIT_FAILURE);
    }

    // Initialize vectors
    for(i=0;i<n;i++) {
        vecA[i] = 1.0 + i;
        vecB[i] = pow(vecA[i],2);
    }

    vector_add(vecA,vecB,vecC,n);

    for(i=0;i<n;i++) {
        sum += vecC[i];
    }

    printf("Sum: %18.1f\n", sum);

    free(vecC),
    free(vecB),
    free(vecA),

    exit(EXIT_SUCCESS);
}

void usage() {
    fprintf(stderr,"vector_add -n <vector-size>\n");
    fprintf(stderr,"Initializes two vectors, adds them\n");
}

void vector_add(double *vecA,double *vecB,double *vecC,const unsigned long int n) {
    unsigned long int i;

    for(i=0;i<n;i++) {
        vecC[i] = vecA[i] + vecB[i];
    }
}
