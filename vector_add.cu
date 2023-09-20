// Loosely based on SC11 nVidia CUDA tutorial - https://www.nvidia.com/docs/IO/116711/sc11-cuda-c-basics.pdf

#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <errno.h>
#include <string.h>
#include <math.h>

void usage();
__global__ void vector_add(double *,double *,double *,const unsigned long int);

int main(int argc,char **argv) {
    int c,device,device_count;
    unsigned long int i,blocks,threads,n;
    double *vecA,*vecB,*vecC,*d_vecA,*d_vecB,*d_vecC,sum;
    cudaError_t cuda_error;

    n = 0;
    blocks = threads = 1;

    cudaGetDevice(&device);
    cudaGetDeviceCount(&device_count);

    fprintf(stderr,"CUDA device = %d/%d\n",device,device_count);

    while((c = getopt(argc,argv,"b:n:t:")) != -1) {
        switch(c) {
            case 'b':
                errno = 0;
                blocks = (unsigned long int)strtoul(optarg, (char**)NULL, 10);
                if(errno) {
                    fprintf(stderr,"Invalid input %s: %s\n",optarg,strerror(errno));
                    usage();
                    exit(EXIT_FAILURE);
                }
                break;
            case 'n':
                errno = 0;
                n = (unsigned long int)strtoul(optarg, (char**)NULL, 10);
                if(errno) {
                    fprintf(stderr,"Invalid input %s: %s\n",optarg,strerror(errno));
                    usage();
                    exit(EXIT_FAILURE);
                }
                break;
            case 't':
                errno = 0;
                threads = (unsigned long int)strtoul(optarg, (char**)NULL, 10);
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

    if(n <= 0 || blocks <= 0 || threads <= 0) {
        fprintf(stderr,"Supply all arguments!\n");
        usage();
        exit(EXIT_FAILURE);
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

    cudaMalloc((void**)&d_vecA,sizeof(double) * n);
    cudaMalloc((void**)&d_vecB,sizeof(double) * n);
    cudaMalloc((void**)&d_vecC,sizeof(double) * n);

    // Initialize vectors
    for(i=0;i<n;i++) {
        vecA[i] = 1.0 + i;
        vecB[i] = pow(vecA[i],2);
    }

    cudaMemcpy(d_vecA,vecA,sizeof(double) * n,cudaMemcpyHostToDevice);
    cudaMemcpy(d_vecB,vecB,sizeof(double) * n,cudaMemcpyHostToDevice);

    vector_add<<<blocks,threads>>>(d_vecA,d_vecB,d_vecC,n);
    cuda_error = cudaGetLastError();
    if(cuda_error != cudaSuccess) {
        fprintf(stderr,"CUDA error: %s\n",cudaGetErrorString(cuda_error));
        exit(EXIT_FAILURE);
    }

    cudaMemcpy(vecC,d_vecC,sizeof(double) * n,cudaMemcpyDeviceToHost);

    for(i=0;i<n;i++) {
        sum += vecC[i];
    }

    printf("Sum: %18.16f\n", sum);

    free(vecA);
    free(vecB);
    free(vecC);
    cudaFree(d_vecA);
    cudaFree(d_vecB);
    cudaFree(d_vecC);

    exit(EXIT_SUCCESS);
}

void usage() {
    fprintf(stderr,"vector-add -n <vector-size> -t <threads-per-block>\n");
    fprintf(stderr,"Initializes two vectors, adds them\n");
}

__global__ void vector_add(double *vecA,double *vecB,double *vecC,const unsigned long int n) {
    unsigned long int i;

    for(i=threadIdx.x;i<n;i+=blockDim.x) {
        vecC[i] = vecA[i] + vecB[i];
    }
}
