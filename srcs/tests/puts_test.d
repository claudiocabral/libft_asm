import compare;
import core.stdc.stdio: puts;
import capture_stdout;
import std.stdio: writeln;

void test_puts() {
    compare_stdout!(ft_puts, puts, "abc\0".ptr)();
    compare_stdout!(ft_puts, puts, null)();
    compare_stdout!(ft_puts, puts, "howdy califorina\0".ptr)();
    writeln("ft_puts passed all tests!");
}
