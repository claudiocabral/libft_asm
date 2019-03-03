section .text
    global ft_isalnum
    extern ft_isdigit
    extern ft_isalpha

ft_isalnum:
    call ft_isalpha
    cmp eax, 0x0
    je .is_digit
    ret
.is_digit:
    call ft_isdigit
    ret
