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
    mov r8,rdi


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
    mov [WordCount],dl

    mov rbx,0
    mov rcx,0
    mov cl,dl
    cycle1:
    push rcx

    mov r14,0
    mov rdx,0
    mov cl,bl
    cmp cl,0
    je skip



    ;cycle2:
    push rcx
    push r8
    push r9
    push rsi 
    push rdi
    push rbx
    ; cmp with other words
    ; if found set rdx to 1

    comparewords:


    mov rbx,0
    mov bl,cl
    mov cl,[WordLen+rbx+1]
    sub cl,[WordLen+rbx]
    ;dec cl
    inc cl
    ; cmp BYTE[WordLen+rbx+2],0
    ; jne notdecone
    ; dec cl
    ; notdecone:
    ; push rcx
    ; push r8
    ; mov [Debug],cl
    ; add BYTE[Debug],48
    ; lea rdi,Debug
    ; call _Z6print1Pc
    ; pop r8
    ; pop rcx


    mov r9,r8
    add r9b,[WordLen+rbx]
    mov rsi,r9
    lea rdi,[WordList+r14]

    ; push rcx
    ; push rdx
    ; push rsi
    ; call _Z6print1Pc
    ; pop rsi
    ; push rsi
    ; mov rdi,rsi
    ; call _Z6print1Pc
    ; pop rsi
    ; pop rdx
    ; pop rcx

    rep cmpsb
    cmp cl,0
    jne notfound

    mov rdx,1    
    jmp found
    notfound:
    
    notspace:
    ; inc r14
    ; cmp BYTE[WordList+r14],0
    ; je  endsearch
    ; cmp BYTE[WordList+r14],32
    ; jne notspace
    ; inc r14

    ; push rcx
    ; push rdx
    ; push rsi
    ; push rdi
    ; lea rdi,[WordList]
    ; call _Z6print1Pc
    ; pop rdi
    ; pop rsi
    ; pop rdx
    ; pop rcx

    ; jmp comparewords

    found:
    endsearch:
    ; для вывода чисел
    ; push r8
    ; mov [Debug],rbx
    ; add BYTE[Debug],48
    ; lea rdi,Debug
    ; call _Z6print1Pc
    ; pop r8

    ; ; для вывода строк





    pop rbx
    pop rdi
    pop rsi
    pop r9
    pop r8
    pop rcx
    ;loop cycle2



    skip:
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


    ; для вывода чисел
    ; push r8
    ; mov [Debug],r12
    ; add BYTE[Debug],48
    ; lea rdi,Debug
    ; call _Z6print1Pc
    ; pop r8

    ; для вывода строк
    ; mov rdi,rdi
    ; call _Z6print1Pc


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
    add BYTE[WordLen],48
    add BYTE[WordLen+1],48
    add BYTE[WordLen+2],48
    add BYTE[WordLen+3],48
    add BYTE[WordLen+4],48
    add BYTE[WordCount],48

    lea rdi,WordLen
    call _Z6print1Pc
    lea rdi,WordList
    call _Z6print1Pc
    lea rdi,WordCount
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