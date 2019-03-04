section .text
global _ft_isprint

_ft_isprint:
    cmp edi, 0x20
    js .not_equal
    cmp edi, 0x7e
    jg .not_equal
    mov eax, 0x1
    ret
.not_equal: mov eax, 0x0
    ret
