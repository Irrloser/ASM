#include <stdio.h>
extern  void  _convert(void);
extern  char BUFA;
int INVAL;
#pragma warning(disable:4996)
void main(void)
{
printf("Please  input a number:");
    scanf("%d",&INVAL);
_convert();
printf("%s", &BUFA);
}