module test;

import std.stdio: writeln;
import std.conv: to;
import std.string: toStringz;
import core.stdc.ctype;
import core.stdc.string;
import std.meta: AliasSeq;
import bsd_functions;
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
}




void test_memory_functions() {
    char[1024] my_buffer;
    char[1024] other_buffer;
    alias strings = AliasSeq!(
            "asdf",
            "asdfasfa",
            "aksjflkasjflajflajfaj",
            ""
            );

    foreach (s; strings) {
        auto my_res = ft_memcpy(cast(void *)my_buffer.ptr, cast(void *)s.ptr, s.length);
        memcpy(cast(void *)other_buffer.ptr, cast(void *)s.ptr, s.length);
        assert(my_buffer == other_buffer, "my buffer: " ~ my_buffer ~ "\noriginal: " ~ other_buffer);
        assert(my_res == my_buffer.ptr, "return values don't match");
    }
    writeln("ft_memcpy passed all tests");
    foreach (i; [ 0, 1, 2, 3, 4, 5 ]) {
        auto my_res = ft_memset(cast(void *)my_buffer.ptr, i, my_buffer.length);
        memset(cast(void *)other_buffer.ptr, i, other_buffer.length);
        assert(my_buffer == other_buffer, "my buffer: " ~ my_buffer ~ "\noriginal: " ~ other_buffer);
        assert(my_res == my_buffer.ptr, "return values don't match");
    }
    writeln("ft_memset passed all tests");
}

int not_zero(int a, int b) {
    return (a == 0) == (b == 0);
}

void compare_output_impl(alias F, alias G, alias C = (a, b) => a == b, args...)(string msg) {
    auto mine = F(args);
    auto original = G(args);
    auto results =
        "\n" ~ __traits(identifier, F) ~ ": " ~ mine.to!string
        ~ "\n" ~ __traits(identifier, G) ~ ": " ~ original.to!string;
    assert(C(mine, original), msg ~ results);
}

void compare_output(alias func, alias compare, string msg, args...)() {
    enum name = __traits(identifier, func)[3 .. $];
    alias other_func = __traits(getMember, test, name);
    string error_msg = name ~ " with args " ~ args.to!string ~ ": " ~ msg;
    compare_output_impl!(func, other_func, compare,args)(error_msg);
}

void main() {
    alias is_functions = AliasSeq!(
            "ft_isalpha",
            "ft_isalnum",
            "ft_isdigit",
            "ft_isprint",
            "ft_isascii"
            );
    foreach (f; is_functions) {
        foreach (i; ubyte.min .. ubyte.max) {
            compare_output!(mixin(f), not_zero, "results don't match", i)();
        }
        writeln(f ~ " passed all tests");
    }
    alias to_functions = AliasSeq!(
            "ft_toupper",
            "ft_tolower",
            );
    foreach (f; to_functions) {
        foreach (i; ubyte.min .. ubyte.max) {
            compare_output!(mixin(f), (a, b) => (a == b), "results don't match", i)();
        }
        writeln(f ~ " passed all tests");
    }
    alias strings = AliasSeq!(
            "asdf\0",
            "asdfasfa\0",
            "aksjflkasjflajflajfaj\0",
            ""
            );

    foreach (alias s; strings) {
        compare_output!(ft_strlen, (a, b) => (a == b),
                "results don't match", s.ptr)();
    }
    writeln("ft_strlen passed all tests");
    test_memory_functions();
}
