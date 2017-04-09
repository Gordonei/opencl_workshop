#define data_t float
    
// Matrix multiplication
// a - M x N
// b - N x M, stored column-major (Fortran) style
// c - M x M
kernel void dot_product(global data_t *a,
                        global data_t *b,
                        global data_t *c,
                        local data_t *local_b,
                        int m,
                        int n)
{
    int row = get_global_id(0);
    int col = get_global_id(1);

    int a_offset = row*n; //start of row of a
    int b_offset = col*n; //start of col of b
    
    //Calculation loop
    data_t sum = 0; //private variable used to cache result
    for(int i=0;i<n;++i) sum += a[a_offset + i] * b[b_offset+i];
    
    int c_index = row*m + col;
    c[c_index] = sum;
}

// Matrix multiplication
// a - M x N
// b - N x M, stored column-major (Fortran) style
// c - M x M
kernel void dot_product_cc(global data_t *a,
                           global data_t *b,
                           global data_t *c,
                           local data_t *local_b,
                           int m,
                           int n)
{  
    int row = get_global_id(0);
    int col = get_global_id(1);

    int a_offset = row*n; //start of row of a
    int b_offset = col*n; //start of col of b
    
    // Moving column into local memory
    async_work_group_copy(local_b,&b[b_offset],n,0);
    barrier(CLK_LOCAL_MEM_FENCE);
    
    //Calculation loop
    data_t sum = 0; //private variable used to cache result
    for(int i=0;i<n;++i) sum += a[a_offset + i] * local_b[i];
    
    int c_index = row*m + col;
    c[c_index] = sum;
}