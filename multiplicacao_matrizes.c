#include <stdio.h>

#define ROW1 2
#define COL1 2
#define ROW2 2
#define COL2 2

void matrix_multiplication(int mat1[][COL1], int mat2[][COL2], int result[][COL2]) {
    int i, j, k;

    for(i = 0; i < ROW1; i++) {
        for(j = 0; j < COL2; j++) {
            for(k = 0; k < COL1; k++) {
                result[i][j] += mat1[i][k] * mat2[k][j];
            }
        }
    }
}


int main() {
    int mat1[ROW1][COL1] = { {1, 2},
                             {2, 1} };

    int mat2[ROW2][COL2] = { {3, 3},
                             {2, 2} };

    int result[ROW1][COL2];

    for(int i = 0; i < ROW1; i++) {
        for(int j = 0; j < COL2; j++) {
            result[i][j] = 0;
        }
    }

    matrix_multiplication(mat1, mat2, result);

    return 0;
}
