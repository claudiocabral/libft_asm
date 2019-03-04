section .text
global _ft_tolower
extern _ft_isupper

_ft_tolower:
    call _ft_isupper
    cmp eax, 0
    mov eax, edi
    je .end
    add eax, 0x20
.end:
    ret
