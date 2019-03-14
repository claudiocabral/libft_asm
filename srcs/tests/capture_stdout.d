import core.sys.posix.unistd;
import core.sys.posix.stdlib;
import std.exception: enforce;
import core.stdc.stdio: SEEK_SET, EOF;
import std.stdio: writeln, stdout;
import std.utf: toUTFz;
import std.conv: to;
import compare;

void compare_stdout(alias F, alias G, Args...)() {
    auto filename = toUTFz!(char *)("/tmp/tempXXXX\0");
    auto save = dup(1);
    auto tmpfile = mkstemp(filename);
    dup2(tmpfile, 1);
    auto my_ret = F(Args);
    stdout.flush();
    lseek(1, 0, SEEK_SET);
    char[1024] buffer;
    ulong size;
    string mine;
    while ((size = read(1, buffer.ptr, buffer.length)) > 0) {
        mine ~= buffer[0 .. size];
    }
    enforce(size != -1, "error reading tmp");
    enforce(mine.length > 0, "nothing was written to mine");
    close(tmpfile);
    filename = toUTFz!(char *)("/tmp/tempXXXX\0");
    tmpfile = mkstemp(filename);
    dup2(tmpfile, 1);
    auto their_ret = G(Args);
    stdout.flush();
    lseek(1, 0, SEEK_SET);
    string theirs;
    while ((size = read(1, buffer.ptr, buffer.length)) > 0) {
        theirs ~= buffer[0 .. size];
    }
    close(tmpfile);
    dup2(save, 1);
    close(save);
    enforce(mine == theirs, "results don't match:\n"
             ~ "mine: " ~ mine
             ~ "theirs: " ~ theirs
             );
    enforce((my_ret != EOF) == (their_ret != EOF), "return values don't match:\n"
             ~ "mine: " ~ my_ret.to!string
             ~ "\ntheirs: " ~ their_ret.to!string
             );
}
