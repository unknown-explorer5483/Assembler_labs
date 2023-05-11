    section .data

    section .bss
WordList     resb 256
WordLen      resb 25
WordCount    resb 1

global _Z4str1PKc
extern _Z6print1Pc
extern _Z10printdebugib
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

    mov r8,rdi

    call getwordspos

    mov rbx,0
    mov rcx,0
    mov cl,dl
    cycle1:
    push rcx

    mov r14,0
    mov rdx,0
    mov cl,bl



    call isunique


    cmp rdx,0
    jne skipadd
    push rcx
    push rdi
    push rsi

    mov cl,[WordLen+rbx+1]
    sub cl,[WordLen+rbx]
    dec cl

    push rcx
    mov r9,r8
    add r9b,[WordLen+rbx]
    mov RSI,r9
    lea RDI,[WordList+r12]
    rep movsb
    pop rcx

    add r12b,cl
    mov BYTE[WordList+r12],32
    inc r12b





    pop rsi 
    pop rdi
    pop rcx  
    skipadd:
    pop rcx
    inc rbx    
    dec ecx
    jnz cycle1

    pop r14
    pop r12
    pop r9
    pop r8
    pop rsi
    pop rdi

    lea rdi,[WordList]
    call _Z6print1Pc


    pop rdx
    pop rbx
    pop rax 
    pop rcx 
    mov rsp,rbp 
    pop rbp 
    lea rax,[WordList]    
    ret

    getwordspos:

    mov r12,0
    mov rbx,-1
    mov rdx,1
    nextsym:
    inc rbx
    cmp BYTE[r8+rbx],0
    je after
    cmp BYTE[r8+rbx],32
    jne nextsym
    mov [WordLen+rdx],bl
    inc BYTE[WordLen+rdx]
    inc rdx
    inc BYTE[WordCount]    
    jmp nextsym
    after:
    mov [WordLen+rdx],bl
    inc BYTE[WordLen+rdx]


    ret

    isunique:
    push rcx
    push r8
    push r9
    push rsi 
    push rdi
    push rbx
    push r12
    mov rdx,0   ; not found

    mov rbx,0
    mov bl,cl
    mov cl,[WordLen+rbx+1]
    sub cl,[WordLen+rbx]
    dec cl

    push rbx
    mov r12,rbx    
cmpagain:
    cmp BYTE[WordLen+rbx+2],0
    je endcmp

    mov cl,[WordLen+r12+1]
    sub cl,[WordLen+r12]
    dec cl


    mov rsi,0
    mov rdi,0
    mov sil,[WordLen+rbx+1]
    mov r14,r8
    add rsi,r14
    mov dil,[WordLen+r12]
    add rdi,r14
    inc cl
    inc cl
    rep cmpsb
    cmp cl,0
    jne notfound

    mov rdx,1  ; found   
    jmp endcmp

    notfound:
    
    
    inc rbx
    jmp cmpagain
endcmp:
    pop rbx

    ; push rdi
    ; push rsi 
    ; push rax
    ; push rdx

    ; mov rdi,rbx
    ; mov rsi,rdx
    ; call printdebug

    ; pop rdx
    ; pop rax
    ; pop rsi
    ; pop rdi

    pop r12
    pop rbx
    pop rdi
    pop rsi
    pop r9
    pop r8
    pop rcx

    ret

printdebug:

    cmp [WordCount],bl
    je skipprint
    call _Z10printdebugib
    skipprint:
    ret