import std.meta: AliasSeq;
import std.stdio: writeln;
import compare;

void test_strlen() {
    alias strings = AliasSeq!(
            "asdf\0",
            "asdfasfa\0",
            "aksjflkasjflajflajfaj\0",
            "",
            );

    foreach (alias s; strings) {
        compare_output!(ft_strlen, (a, b) => (a == b),
                "results don't match", s.ptr)();
    }
    ft_strlen(null);
    writeln("ft_strlen passed all tests");
}
