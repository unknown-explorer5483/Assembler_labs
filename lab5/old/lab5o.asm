    section .data

    section .bss
WordList    resb 256
WordLen     resb 25
WordCount   resb 1
WordListLen resb 1
Debug       resb 1

global _Z4str1PKc
extern _Z6print1Pc
    section .text 
_Z4str1PKc:  
	push rbp 
    mov rbp,rsp 
    push rcx 
    push rax 
    push rbx
    push rdx
    push rdi
    push rsi
    push r8
    push r9
    push r12
    push r14
   
    call _Z6print1Pc

    pop r14
    pop r12
    pop r9
    pop r8
    pop rsi
    pop rdi
    pop rdx
    pop rbx
    pop rax 
    pop rcx 
    mov rsp,rbp 
    pop rbp 
    ret