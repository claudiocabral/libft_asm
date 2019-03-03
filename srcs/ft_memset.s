section .text:
global ft_memset

ft_memset:
.loop:
    mov rax, rdi
    cmp rdx, 0
    je .end
    mov byte[rdi], rsi

.end:
    ret
