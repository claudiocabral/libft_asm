section .text
global _ft_isalpha
global _ft_isupper
global _ft_islower

_ft_isalpha:
    call _ft_isupper
    cmp eax, 0x0
    je .is_lower
    ret
.is_lower:
    call _ft_islower
    ret

_ft_isupper:
    cmp edi, 0x41
    js .not_equal
    cmp edi, 0x5a
    jg .not_equal
    mov rax, 0x1
    ret
.not_equal: mov rax, 0x0
    ret

_ft_islower: cmp edi, 0x61
    js .not_equal
    cmp edi, 0x7a
    jg .not_equal
    mov rax, 0x1
    ret
.not_equal: mov rax, 0x0
    ret
