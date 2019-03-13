%define MACH_SYSCALL(nb) 0x2000000 | nb
%define STDOUT 0x1
%define READ 0x3
%define WRITE 0x4
%define BUFF_SIZE 0x400
%define STACK_SIZE 0x410

section .text
global _ft_cat

_ft_cat:
    push rbp
    mov rbp, rsp
    sub rsp, STACK_SIZE
    mov [rsp], edi
.loop:
    mov edi, [rsp]
    lea rsi, [rsp + 0x10]
    mov rdx, BUFF_SIZE
    mov rax, MACH_SYSCALL(READ)
    syscall
    jae .continue
    leave
    ret
.continue:
    cmp rax, 0
    jle .finalize
    mov rdi, STDOUT
    lea rsi, [rsp + 0x10]
    mov rdx, rax
    mov rax, MACH_SYSCALL(WRITE)
    syscall
    jmp .loop
.finalize:
    leave
    ret
