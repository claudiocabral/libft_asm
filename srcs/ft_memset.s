section .text
global _ft_memset

_ft_memset:
    mov rax, rsi
    mov rsi, rdi
    mov rcx, rdx
    cld
    rep stosb
    mov rax, rsi
    ret
