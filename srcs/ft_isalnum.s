section .text
    global _ft_isalnum
    extern _ft_isdigit
    extern _ft_isalpha

_ft_isalnum:
    call _ft_isalpha
    cmp eax, 0x0
    je .is_digit
    ret
.is_digit:
    call _ft_isdigit
    ret
