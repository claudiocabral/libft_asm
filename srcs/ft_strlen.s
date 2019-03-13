section .text
global _ft_strlen

_ft_strlen:
    xor rax, rax
    cmp rdi, 0
    je .end
    mov rcx, -1
    mov rsi, rdi
    cld
    repne scasb
    dec rdi
    sub rdi, rsi
    mov rax, rdi
.end:
    ret
