    section .data
String db "abo aba aba ",10,0
String2 db "                                        ",0

Enter2 db 10

    section .bss
WordList     resb 256
WordLen      resb 25
; WordCount    resb 1


    section .text 
    global _start
_start:
	; push rbp 
    ; mov rbp,rsp 
    ; push rcx 
    ; push rax 
    ; push rbx
    ; push rdx
    ; push rdi
    ; push rsi
    ; push r8
    ; push r9
    ; push r12
    ; push r14
    lea r8,[String]

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
    ;mov rdx,0


    cmp rdx,0
    jne skipadd
    push rcx
    push rdi
    push rsi

    mov cl,[WordLen+rbx+1]
    sub cl,[WordLen+rbx]
    dec cl


    ;mov RCX, wordlen done
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
    ; loop cycle1
    dec ecx
    jnz cycle1
    ;cmp 
    ;mov al,0
    ;mov [WordList+250],al
    ;mov rdi,[WordList]
    ; add BYTE[WordLen],48
    ; add BYTE[WordLen+1],48
    ; add BYTE[WordLen+2],48
    ; add BYTE[WordLen+3],48
    ; add BYTE[WordCount],48
    
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    lea rsi, [WordList] ; адрес выводимой строки
    mov rdx, 25; длина строки
    syscall

    ; mov rax, 1; системная функция 1 (write)
    ; mov rdi, 1; дескриптор файла stdout=1
    ; lea rsi, [WordLen] ; адрес выводимой строки
    ; mov rdx, 20; длина строки
    ; syscall



    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    lea rsi, [Enter2] ; адрес выводимой строки
    mov rdx, 1; длина строки
    syscall

    



    mov rax, 60; системная функция 60 (exit)
    xor rdi, rdi; return code 0
    syscall

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
    jmp nextsym
    after:
    mov [WordLen+rdx],bl
    inc BYTE[WordLen+rdx]
    ; mov [WordCount],dl

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
    ;inc cl

    ;call debugprint
    ; correct ++
    push rbx
    mov r12,rbx    
cmpagain:
    cmp BYTE[WordLen+rbx+2],0
    je endcmp

    ; mov cl,bl
    ; call debugprint

    
    ; mov cl,[WordLen+rbx]
    ; call debugprint
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

    pop r12
    pop rbx
    pop rdi
    pop rsi
    pop r9
    pop r8
    pop rcx

    ret
; debugprint:
;     push rax
;     push rdi
;     push rsi
;     push rdx

;     mov [Debug],cl
;     add Byte[Debug],48

;     mov rax, 1; системная функция 1 (write)
;     mov rdi, 1; дескриптор файла stdout=1
;     lea rsi, [Debug] ; адрес выводимой строки
;     mov rdx, 1
;     syscall


;     pop rdx
;     pop rsi
;     pop rdi
;     pop rax
;     ret
; debugprint2:
;     push rax
;     push rdi
;     push rsi
;     push rdx

;     mov rax, 1; системная функция 1 (write)
;     mov rdi, 1; дескриптор файла stdout=1
;     lea rsi, [Debug] ; адрес выводимой строки
;     mov rdx, 100
;     syscall


;     pop rdx
;     pop rsi
;     pop rdi
;     pop rax
;     ret
