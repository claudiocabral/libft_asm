section .text
global ft_isalpha
global ft_isupper
global ft_islower

ft_isalpha:
    call ft_isupper
    cmp eax, 0x0
    je .is_lower
    ret
.is_lower:
    call ft_islower
    ret

ft_isupper:
    cmp edi, 0x41
    js .not_equal
    cmp edi, 0x5a
    jg .not_equal
    mov rax, 0x1
    ret
.not_equal: mov rax, 0x0
    ret

ft_islower: cmp edi, 0x61
    js .not_equal
    cmp edi, 0x7a
    jg .not_equal
    mov rax, 0x1
    ret
.not_equal: mov rax, 0x0
    ret
