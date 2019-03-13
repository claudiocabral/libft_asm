module test;

import std.stdio: writeln;
import std.string: toStringz;
import std.meta: AliasSeq;
import core.sys.posix.unistd;
import compare;
import strlen;
import memory;
import cat;
import puts_test;


int not_zero(int a, int b) {
    return (a == 0) == (b == 0);
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
    test_strlen();
    test_memory_functions();
    test_cat();
    test_puts();
}
