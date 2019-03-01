#include <ft.h>
#include <stdio.h>

void print_result(int c)
{
    if (ft_isalpha(c))
        printf("%c is alpha\n", c);
    else
        printf("%c is NOT alpha\n", c);
}

int main(void)
{
    int i;

    i = 0;
    while (i < 127) {
        print_result(i);
        ++i;
    }
}
