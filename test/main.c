#include <stdio.h>

extern int init(int x);

int main()
{
	int x = 20;
	init(x);
	return 0;
}
