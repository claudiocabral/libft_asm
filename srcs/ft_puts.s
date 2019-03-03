%define MACH_SYSCALL(nb) 0x2000000 | nb
%define STDOUT 0x1
%define WRITE 0x4

section .text
global ft_puts
extern ft_strlen

ft_puts:
    call ft_strlen
    mov rsi, rdi
    mov rdi, STDOUT
    mov rdx, rax
    mov rax, MACH_SYSCALL(WRITE)
    syscall
    leave
    ret
