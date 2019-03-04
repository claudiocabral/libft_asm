section .text
global _ft_bzero
extern _ft_memset

_ft_bzero:
    mov rdx, rsi
    mov rsi, 0
    call _ft_memset
    ret
