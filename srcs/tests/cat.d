import compare;
import std.conv: to;
import std.stdio: writeln;
import std.file: read;
import core.sys.posix.unistd;
import core.sys.posix.fcntl;
import capture_stdout;

void test_cat()
{
    auto paths = [
        "srcs/ft_strcat.s\0",
        "Makefile\0",
    ];
    foreach (path; paths) {
        compare_stdout!(cat_read_file, read_file, path)();
    }
    auto fd = open("/dev/stdin\0", O_RDONLY);
    if (fd) {
        ft_cat(fd);
    }
    close(fd);
    writeln("ft_cat passed all tests!");
}

long cat_read_file(string path) {
    auto fd = open(path.ptr, O_RDONLY);
    ft_cat(fd);
    close(fd);
    return (1);
}

long read_file(string my_path) {
    auto buf = read(my_path);
    return write(1, buf.ptr, buf.length);
}
