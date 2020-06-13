#include <stdio.h>
#include "gputimer.h"

#define NUM_THREADS 1000000
#define BLOCK_WIDTH 1000
#define ARRAY_SIZE 10

__global__ void add_naive(int *arr){
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    i= i%ARRAY_SIZE;
    arr[i] = arr[i]+1;
}

__global__ void add_atomic(int *arr){
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    i= i%ARRAY_SIZE;
    atomicAdd(&arr[i],1);
}

int main(int argc, char **argv){
    
    GpuTimer timer;
    int h_arr[ARRAY_SIZE];
    memset(h_arr, 0, sizeof(h_arr));

    int *d_arr;
    cudaMalloc((void **) &d_arr, ARRAY_SIZE*sizeof(int));
    cudaMemcpy(d_arr, h_arr, ARRAY_SIZE*sizeof(int), cudaMemcpyHostToDevice);

    timer.Start();
    add_atomic<<<NUM_THREADS/BLOCK_WIDTH, BLOCK_WIDTH>>>(d_arr);
    timer.Stop();

    cudaMemcpy(h_arr, d_arr, ARRAY_SIZE*sizeof(int), cudaMemcpyDeviceToHost);
    for(int i=0;i<ARRAY_SIZE;i++) printf("%d, ",h_arr[i]);
    printf("\nTime taken: %g ms\n", timer.Elapsed());

    cudaFree(d_arr);
    return 0;
}