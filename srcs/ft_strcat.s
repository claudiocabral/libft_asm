section .text
global _ft_strcat
extern _ft_strlen

_ft_strcat:
    mov rax, 0
    mov rdx, rdi ; save dst at rdx
    mov r8, rsi ; save src at r8
    mov rsi, rdi
    mov rcx, -1
    cld
    repne scasb ; advance dst to end
    dec rdi
    mov r9, rdi ; save new dst to r9
    mov rdi, r8 ; put src at rdi to call strlen
    call _ft_strlen ; get size of src
    mov rcx, rax
    mov rdi, r9
    mov rsi, r8
    rep movsb ; cpy src to dst
    mov rax, rdx
    ret
