import compare;
import std.conv: to;
import std.stdio: writeln;
import core.sys.posix.unistd;
import core.sys.posix.fcntl;

void test_cat()
{
    auto paths = [
        "srcs/ft_strcat.s\0",
        "Makefile\0",
        //"/dev/stdin\0",
    ];
    foreach (path; paths) {
        auto fd = open(path.ptr, O_RDONLY);
        ft_cat(fd);
        close(fd);
    }
    char[1024] buf;
    auto ret = read(13, buf.ptr, buf.length);
    ret.to!string.writeln;
    ft_cat(13);
    writeln("ft_cat passed all tests!");
}
