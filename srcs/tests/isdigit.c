#include <ft.h>
#include <stdio.h>

void print_result(int c)
{
    if (ft_isdigit(c))
        printf("%c is digit\n", c);
    else
        printf("%c is NOT digit\n", c);
}

int main(void)
{
    int i;

    i = 32;
    while (i < 100) {
        print_result(i);
        ++i;
    }
}
