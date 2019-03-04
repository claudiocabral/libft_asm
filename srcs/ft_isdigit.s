section .text
global _ft_isdigit

_ft_isdigit:
    cmp rdi, 0x30
    js .not_equal
    cmp rdi, 0x39
    jg .not_equal
    mov rax, 0x800
    ret
.not_equal: mov rax, 0x0
    ret
