   section .data
NewLine db 10

    section .bss
InBuf   resb    10 

global _Z4str1PKc
extern _Z6print1i
  section .text 
_Z4str1PKc:  
	push rbp 
    mov rbp,rsp 
    push rcx 
    push rax 

    mov rsi, rdi
	mov rax, 1
    mov rdi, 1
    mov rdx, 5
    syscall
	mov rdi,[NewLine]
    call _Z6print1i
    pop rax 
    pop rcx 
    mov rsp,rbp 
    pop rbp 
    ret