#include <stdio.h>

int main() {
    double a, b, c, i, j, k;
    
    printf("请输入已知量 a, b, c, i, j, k: ");
    scanf("%lf %lf %lf %lf %lf %lf", &a, &b, &c, &i, &j, &k);
    
    double y = (k+i-j-2*a-2*c+2*b) / 2; 
    double x = (j+i-k-2*a-2*b+2*c) / 2;
    double z = (k+j-i-2*b-2*c+2*a) / 2; 
   
    printf(" %lf,  %lf, %lf\n", x, y, z);
    
    return 0;
}