section .text
global _ft_isascii

_ft_isascii:
    cmp edi, 0x0
    js .not_equal
    cmp edi, 0x7f
    jg .not_equal
    mov eax, 0x1
    ret
.not_equal: mov eax, 0x0
    ret
