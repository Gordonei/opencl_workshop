// Matrix multiplication
// Row of A is element-wise multipled by col of B, then all elements are summed
// a - M x N matrix
// b - N x M matrix
// c - M x M matrix
kernel void dot_product(global int *a,
                        global int *b,
                        global int *c,
                        int m,
                        int n)
{   
    int row = get_global_id(0);
    int col = get_global_id(1);

    int a_offset = row*n; //Start of row in a
    int b_offset = col; //Start of col in b
    int b_stride = m; //How far we step to get to next column value
    
    int c_index = row*m + col; //destination of output
    
    //Calculation loop
    c[c_index] = 0;
    for(int i=0;i<n;++i) c[c_index] += a[a_offset + i] * b[b_offset + b_stride*i];
}

// Matrix multiplication
// The result is first calculated then written to global memory
// a - M x N
// b - N x M
// c - M x M
kernel void dot_product_cached(global int *a,
                               global int *b,
                               global int *c,
                               int m,
                               int n)
{
    int row = get_global_id(0);
    int col = get_global_id(1);

    int a_offset = row*n; //Start of row in a
    int b_offset = col; //Start of col in b
    int b_stride = m;
    
    //Calculation loop
    int sum = 0; //private variable used to cache result
    for(int i=0;i<n;++i) sum += a[a_offset + i] * b[b_offset + b_stride*i];
    
    int c_index = row*m + col;
    c[c_index] = sum;
}

// Matrix multiplication
// a - M x N
// b - N x M, stored column-major (Fortran) style
// c - M x M
kernel void dot_product_no_stride(global int *a,
                                  global int *b,
                                  global int *c,
                                  int m,
                                  int n)
{
    int row = get_global_id(0);
    int col = get_global_id(1);

    int a_offset = row*n; //start of row of a
    int b_offset = col*n; //start of col of b
    
    //Calculation loop
    int sum = 0; //private variable used to cache result
    for(int i=0;i<n;++i) sum += a[a_offset + i] * b[b_offset+i];
    
    int c_index = row*m + col;
    c[c_index] = sum;
}