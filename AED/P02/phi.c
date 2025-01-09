#include <stdio.h>
#include <math.h>

double phi(int n){
	if(n==0){
		return 1;
	}
	return 1+1/phi(n-1);
}

int main(){
	int n;
	printf("n? ");
	scanf("%d", &n);
	printf("phi = %f\n", phi(n));
	return 0;
}
