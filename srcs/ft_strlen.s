section .text
global _ft_strlen

_ft_strlen:
    mov rax, 0
    mov rsi, rdi
    mov rcx, -1
    cld
    repne scasb
    dec rdi
    sub rdi, rsi
    mov rax, rdi
    ret
