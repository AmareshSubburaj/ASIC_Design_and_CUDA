
#include <stdio.h>
#include "iostream"
#include "fstream"
#include "string"
#include "sstream"
#include "iomanip"
#include <cuda_runtime.h>
using namespace std;

//Kernel function to calculate the 2d convolution.

__global__ void
Convolute(const double *Matrix_A, const double *Matrix_B, double *Matrix_C, int row_matrix1, int column_matrix1,int row_matrix2,int column_matrix2,int row_matrix3,int column_matrix3, int numElements)
{
	int Row_C = blockDim.x * blockIdx.x + threadIdx.x;
	int Column_C = blockDim.y * blockIdx.y + threadIdx.y;

    if (Row_C <=row_matrix3 && Column_C <= column_matrix3)
    {
	
	Matrix_C[Row_C*column_matrix3+ Column_C] =0;
		
	for (int Row_B = 0; Row_B<row_matrix2; Row_B++)
	for (int Column_B = 0; Column_B < column_matrix2; Column_B++)
	{

	if ((  (Row_C - Row_B)>=0 && (Row_C - Row_B)< row_matrix1) && ((Column_C - Column_B)>=0 && (Column_C - Column_B) < column_matrix1))
	{		
	
	Matrix_C[Row_C*column_matrix3 + Column_C] += (Matrix_B[Row_B*(column_matrix2) + Column_B] * Matrix_A[(Row_C - Row_B)*(column_matrix1) + (Column_C - Column_B)]);

	}
	
	
    }


  }

}


int main(int argc, char* argv[])
{
    string Filename;

    // Error code to check return values for CUDA calls
    cudaError_t err = cudaSuccess;

    //Get the file name from command prompt
    if (argc == 2)
  {

 	 if(argv[1]!=NULL)
   	 Filename = argv[1];

	ifstream iFile;

	iFile.open(Filename.c_str());
	stringstream ss;
	string str_line, str_element;
	bool select_matrix1 = true;
	int column_matrix1 = 0, row_matrix1 = 0, column_matrix2 = 0, row_matrix2 = 0, is_zero = 1;

/***********************get rows and columns*********************************/

	while (getline(iFile, str_line)) {
		ss.str("");
		ss.clear();
		ss << str_line;
		is_zero = str_line.size();

		if ((str_line != "") && (select_matrix1 == true))
		{
			if (column_matrix1 == 0)
				while (ss >> str_element)++column_matrix1;
			++row_matrix1;
		}

		if ((str_line != "") && (select_matrix1 == false))
		{
			if (column_matrix2 == 0)
				while (ss >> str_element)++column_matrix2;
			++row_matrix2;
		}

		if (is_zero == 0)
		{
			select_matrix1 = false;
			is_zero = 1;			
		}
	}

	iFile.close();

/*********************Insert Values into Matrix*********************************/

	//calculate the size of arrays to be allocated in kernel	
	size_t d_A_size = row_matrix1*column_matrix1* sizeof(double);
	size_t d_B_size = row_matrix2*column_matrix2* sizeof(double);
	

	int row_matrix3 = 0, column_matrix3 = 0;
	row_matrix3 = row_matrix1 + row_matrix2 - 1;   
	column_matrix3 = column_matrix1 + column_matrix2 - 1;
	int Matrix_C_size = column_matrix3 * row_matrix3;
	size_t d_C_size = Matrix_C_size*sizeof(double);
	//Total elements.


	double *h_Matrix_C = (double *)malloc(d_C_size);
	double *h_Matrix_A = (double *)malloc(d_A_size); 
	double *h_Matrix_B = (double *)malloc(d_B_size); 

	select_matrix1 = true;
	int Matrix_A_index = 0, Matrix_B_index = 0;

	iFile.open(Filename.c_str());

	while (getline(iFile, str_line)) {

		ss.str("");
		ss.clear();
		ss << str_line;
		is_zero = str_line.size();

		if (is_zero == 0)
		{
			select_matrix1 = false;
			ss.str("");
		}

		{

		if ((str_line != "") && (select_matrix1 == true))
		{

			while (ss >> str_element)
			{
				h_Matrix_A[Matrix_A_index] = atof(str_element.c_str());
				Matrix_A_index++;
			}
		}


		if ((str_line != "") && (select_matrix1 == false))
		{			
			while (ss >> str_element)
			{	

				h_Matrix_B[Matrix_B_index] = atof(str_element.c_str());
				Matrix_B_index++;
			}			
		}
	  }
	}
	iFile.close();

		

/**************************Allocate memory for host arrays*************************/
    double *d_A = NULL;
    err = cudaMalloc((void **)&d_A, d_A_size);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to allocate device Matrix A (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    double *d_B = NULL;
    err = cudaMalloc((void **)&d_B, d_B_size);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to allocate device Matrix B (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    double *d_C = NULL;
    err = cudaMalloc((void **)&d_C, d_C_size);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to allocate device Matrix C (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }


/*******************************copy value from host to device***********************/
    err = cudaMemcpy(d_A, h_Matrix_A, d_A_size, cudaMemcpyHostToDevice);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to copy Matrix A from host to device (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    err = cudaMemcpy(d_B, h_Matrix_B, d_B_size, cudaMemcpyHostToDevice);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to copy Matrix B from host to device (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    // Launch CUDA Kernel
    dim3 threadsPerBlock(16,16);
    dim3 blocksPerGrid((row_matrix3 + threadsPerBlock.x - 1) / threadsPerBlock.x, (column_matrix3 + threadsPerBlock.y - 1) / threadsPerBlock.y);
    Convolute<<<blocksPerGrid, threadsPerBlock>>>(d_A, d_B, d_C, row_matrix1,column_matrix1,row_matrix2,column_matrix2,row_matrix3,column_matrix3,Matrix_C_size);
    err = cudaGetLastError();

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to launch Convolute kernel (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    err = cudaMemcpy(h_Matrix_C, d_C, d_C_size, cudaMemcpyDeviceToHost);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to copy vector C from device to host (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    // Print out the results
	for (int Row_C = 0; Row_C < row_matrix3; Row_C++)
	{
		if(Row_C!=0)		
		cout << "\n";

		for (int Column_C = 0; Column_C < column_matrix3; Column_C++)
		{
			cout <<std::fixed<<std::setprecision(3)<< h_Matrix_C[Row_C*column_matrix3 + Column_C] << " ";
		}
	} 

    // Free device global memory
    err = cudaFree(d_A);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to free device Matrix A (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    err = cudaFree(d_B);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to free device Matrix B (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    err = cudaFree(d_C);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to free device Matrix C (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    // Free host memory


    free(h_Matrix_A);
    free(h_Matrix_B);
    free(h_Matrix_C);


    err = cudaDeviceReset();

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to deinitialize the device! error=%s\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    }
    return 0;
   
}

