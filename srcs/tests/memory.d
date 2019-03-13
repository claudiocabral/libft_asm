import std.stdio: writeln;
import std.meta: AliasSeq;
import core.stdc.string;
import core.stdc.stdlib;
import std.exception: enforce;
import compare;

extern (C) {
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
            enforce(my_buffer == other_buffer, "my buffer: " ~ my_buffer ~ "\noriginal: " ~ other_buffer);
            enforce(my_res == my_buffer.ptr, "return values don't match");
        }
        writeln("ft_memcpy passed all tests");
        foreach (i; [ 0, 1, 2, 3, 4, 5 ]) {
            auto my_res = ft_memset(cast(void *)my_buffer.ptr, i, my_buffer.length);
            memset(cast(void *)other_buffer.ptr, i, other_buffer.length);
            enforce(my_buffer == other_buffer, "my buffer: " ~ my_buffer ~ "\noriginal: " ~ other_buffer);
            enforce(my_res == my_buffer.ptr, "return values don't match");
        }
        writeln("ft_memset passed all tests");
        my_buffer = "abc\0";
        auto suffix = "defef\0";
        other_buffer = my_buffer;
        strcat(other_buffer.ptr, suffix.ptr);
        ft_strcat(my_buffer.ptr, suffix.ptr);
        enforce(my_buffer == other_buffer, "my buffer: " ~ my_buffer ~ "\noriginal: " ~ other_buffer);
        writeln("ft_strcat passed all tests");
        other_buffer = "huahuahuahua\0";
        auto ptr = ft_strdup(other_buffer.ptr);
        enforce(strcmp(ptr, other_buffer.ptr) == 0, "fail");
        free(ptr);
        ptr = ft_strdup(null);
        enforce(ptr == null, "ptr not null with ft_strdup(null)");
        writeln("ft_strdup passed all tests");
    }
}
