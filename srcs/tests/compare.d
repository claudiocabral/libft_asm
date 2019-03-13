module compare;

import bsd_functions;
import core.sys.posix.unistd;
import core.sys.posix.fcntl;
import core.stdc.ctype;
import core.stdc.string;
import core.stdc.stdlib;
import std.conv: to;
import std.exception: enforce;

extern (C) {
    int ft_bzero(void *s, size_t n);
    char *ft_strcat(char *dest, const char *src);
    int ft_isalpha(int c);
    int ft_isdigit(int c);
    int ft_isalnum(int c);
    int ft_isascii(int c);
    int ft_isprint(int c);
    int ft_toupper(int c);
    int ft_tolower(int c);
    int ft_puts(const char *s);
    ulong ft_strlen(const char *s);
    void *ft_memcpy(const void *dst, const void *src, size_t size);
    void *ft_memset(const void *a, int c, size_t size);
    char *ft_strdup(const char *src);
    void ft_cat(int fd);
}

void compare_output_impl(alias F, alias G, alias C = (a, b) => a == b, args...)(string msg) {
    auto mine = F(args);
    auto original = G(args);
    auto results =
        "\n" ~ __traits(identifier, F) ~ ": " ~ mine.to!string
        ~ "\n" ~ __traits(identifier, G) ~ ": " ~ original.to!string;
    enforce(C(mine, original), msg ~ results);
}

void compare_output(alias func, alias compare_func, string msg, args...)() {
    enum name = __traits(identifier, func)[3 .. $];
    alias other_func = __traits(getMember, compare, name);
    string error_msg = name ~ " with args " ~ args.to!string ~ ": " ~ msg;
    compare_output_impl!(func, other_func, compare_func, args)(error_msg);
}
