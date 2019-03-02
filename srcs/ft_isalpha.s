section .text
global ft_isalpha
global _ft_isalpha

_ft_isalpha:
    call ft_isalpha
    ret

ft_isalpha:
.isupper: cmp edi, 0x41
    js .not_equal
    cmp edi, 0x5a
    jg .islower
    mov ax, 0x400
    ret
.islower: cmp edi, 0x61
    js .not_equal
    cmp edi, 0x7a
    jg .not_equal
    mov ax, 0x400
    ret
.not_equal: mov ax, 0x0
    ret
