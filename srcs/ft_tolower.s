section .text
global ft_tolower
extern ft_isupper

ft_tolower:
    call ft_isupper
    cmp eax, 0
    mov eax, edi
    je .end
    add eax, 0x20
.end:
    ret
