module test;

import std.stdio: writeln;
import std.conv: to;
import core.stdc.ctype;
import std.meta: AliasSeq;

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
}

void compare_impl(alias F, alias G, args...)(string msg)
{
    assert(F(args) == G(args), msg);
}

void compare(alias func, string msg, args...)(){
    enum name = __traits(identifier, func)[3 .. $];
    alias other_func = __traits(getMember, test, name);
    string error_msg = name ~ " with args " ~ args.to!string ~ ": " ~ msg;
    compare_impl!(func, other_func, args)(error_msg);
}


void main() {
    alias functions = AliasSeq!(
            "ft_isalpha",
            "ft_isdigit"
            );
    foreach (f; functions) {
        foreach (i; 0 .. 127) {
            compare!(mixin(f), "results don't match", i)();
        }
        writeln(f ~ " passed all tests");
    }
}
