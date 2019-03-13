import compare;
import core.stdc.stdio: puts;

void test_puts() {
    const str = "if you can read this twice, swell!\0";
    puts(str.ptr);
    ft_puts(str.ptr);
}
