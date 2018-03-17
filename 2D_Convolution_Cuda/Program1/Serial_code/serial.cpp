#include "iostream"
#include "fstream"
#include "string"
#include "sstream"
#include "stdlib.h"

using namespace std;

int main()

{
	
	ifstream iFile;

	iFile.open("inputformat1");
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
	double *Matrix_A = new double [row_matrix1*column_matrix1];
	double *Matrix_B = new double  [row_matrix2*column_matrix2]; 

	select_matrix1 = true;
	int Matrix_A_index = 0, Matrix_B_index = 0;
	double d_A=0, d_B=0;

	iFile.open("inputformat");

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
				 Matrix_A[Matrix_A_index] = atof(str_element.c_str());
				Matrix_A_index++;
			}
		}


		if ((str_line != "") && (select_matrix1 == false))
		{			
			while (ss >> str_element)
			{	

				Matrix_B[Matrix_B_index] = atof(str_element.c_str());
				Matrix_B_index++;
			}			
		}
	  }
	}
	iFile.close();
	
/******************************************Convolution Serial*********************************/

	int row_matrix3 = 0, column_matrix3 = 0;
	row_matrix3 = row_matrix1 + row_matrix2 - 1;   
	column_matrix3 = column_matrix1 + column_matrix2 - 1;
	int Matrix_C_size = column_matrix3 * row_matrix3;
	double *Matrix_C = new double[Matrix_C_size];

	for (int Row_C = 0; Row_C<row_matrix3; Row_C++)         //set all values in the matrix to zero.
		for (int Column_C = 0; Column_C < column_matrix3; Column_C++)
		{
			Matrix_C[Row_C*column_matrix3 + Column_C] = 0;
		}

	for(int Row_C=0; Row_C<row_matrix3; Row_C++)
		for (int Column_C = 0; Column_C < column_matrix3; Column_C++)
		{
				
			for (int Row_B = 0; Row_B<row_matrix2; Row_B++)
				for (int Column_B = 0; Column_B < column_matrix2; Column_B++)
				{
					if ((  (Row_C - Row_B)>=0 && (Row_C - Row_B)< row_matrix1) && ((Column_C - Column_B)>=0 && (Column_C - Column_B) < column_matrix1))
						Matrix_C[Row_C*column_matrix3 + Column_C] += (Matrix_B[Row_B*column_matrix2 + Column_B] * Matrix_A[(Row_C - Row_B)*column_matrix1 + (Column_C - Column_B)]);

				}

		}

	for (int Row_C = 0; Row_C < row_matrix3; Row_C++)
	{
		cout << "\n";
		for (int Column_C = 0; Column_C < column_matrix3; Column_C++)
		{
			cout << Matrix_C[Row_C*column_matrix3 + Column_C] << "\t";
		}
	}

return 0;
	
}
