%define MACH_SYSCALL(nb) 0x2000000 | nb
%define STDOUT 0x1
%define WRITE 0x4

section .data
newline:
    .string db "(null)", 10

section .text
global _ft_puts
extern _ft_strlen

_ft_puts:
    cmp rdi, 0x0
    jne .body
    mov rdi, STDOUT
    mov rsi, [rel newline.string]
    mov rdx, 0x7
    mov rax, MACH_SYSCALL(WRITE)
    syscall
    leave
    ret
.body:
    push rbp
    mov rbp, rsp
    sub rsp, 0x10
    mov rdx, rdi
    call _ft_strlen
    mov rsi, rdx
    mov rdi, STDOUT
    mov rdx, rax
    mov rax, MACH_SYSCALL(WRITE)
    mov [rsp], rax
    syscall
    mov rdi, STDOUT
    lea rsi, [rel newline.string + 0x6]
    mov rdx, 0x1
    mov rax, MACH_SYSCALL(WRITE)
    add [rsp], rax
    syscall
    leave
    ret
