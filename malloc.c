#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <getopt.h>
#include <errno.h>
#include <string.h>
#include <limits.h>

void usage();

int main(int argc,char **argv) {
    int c;
    unsigned long int n = 0,i,*ns;

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
        fprintf(stderr,"Supply number of ints to allocate\n");
        usage();
        exit(EXIT_FAILURE);
    }

    if((ns = malloc(sizeof(unsigned long int)*n)) == NULL) {
        fprintf(stderr,"Failed to allocate array of %lu ints: %s\n",n,strerror(errno));
        exit(EXIT_FAILURE);
    }

    for(i=0;i<n;i++) {
        ns[i] = i;
    }

    exit(EXIT_SUCCESS);
}

void usage() {
    fprintf(stderr,"malloc -n <ints>\n");
    fprintf(stderr,"Allocates an array of size n, and writes into it\n");
}
