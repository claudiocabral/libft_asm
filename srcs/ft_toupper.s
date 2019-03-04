section .text
global _ft_toupper
extern _ft_islower

_ft_toupper:
    call _ft_islower
    cmp eax, 0
    mov eax, edi
    je .end
    sub eax, 0x20
.end:
    ret
