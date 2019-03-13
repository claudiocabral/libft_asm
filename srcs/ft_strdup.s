section .text
global _ft_strdup
extern _ft_strlen
extern _malloc

_ft_strdup:
    cmp rdi, 0
    je .error
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rsp], rdi
    call _ft_strlen
    mov [rsp + 8], rax
    mov rdi, rax
    call _malloc
    cmp rax, 0
    je .finalize
    mov rcx, [rsp + 8]
    mov rdi, rax
    mov rsi, [rsp]
    cld
    rep movsb
.finalize:
    leave
    ret
.error:
    xor rax, rax
    ret
