#ifndef FT_H
# define FT_H

#include <string.h>

int     ft_bzero(void *s, size_t n);
char    *ft_strcat(char *dest, const char *src);
int     ft_isalpha(int c);
int     ft_isdigit(int c);
int     ft_isalnum(int c);
int     ft_isascii(int c);
int     ft_isprint(int c);
int     ft_toupper(int c);
int     ft_tolower(int c);
int     ft_puts(const char *s);

#endif
