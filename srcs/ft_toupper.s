section .text
global ft_toupper
extern ft_islower

ft_toupper:
    call ft_islower
    cmp eax, 0
    mov eax, edi
    je .end
    sub eax, 0x20
.end:
    ret
