   section .data

NewLine db 10

EntrMsg db "Enter number (row #):",10
lenEntr equ $-EntrMsg  

ExitMsg db "Answer:",10
lenExit equ $-ExitMsg



    section .bss

InBuf   resb    10 
lenIn   equ     $-InBuf
OutBuf  resb    20
lenOut  equ     10


MAS     resw    20
RESM    resw    5

    section .text 
    global _start
_start:

    mov EDX,0
    mov EBX,0
    mov ECX,5
    cycle:
    push RCX
    push RDX
    add DL,49
    mov [EntrMsg+18],DL

    mov ECX,4
    cycle7:

    mov rax, 1
    mov rdi, 1
    mov rsi, EntrMsg 
    mov rdx, lenEntr
    push RCX
    syscall
    pop  RCX


    mov rax, 0
    mov rdi, 0
    mov rsi, InBuf
    mov rdx, lenIn

    push RCX
    syscall
    pop  RCX
    push RBX
    mov     esi,InBuf  
    call    StrToInt64
    cmp     EBX, 0   
    jne     StrToInt64.Error 
    pop  RBX  
    mov     [EBX*2+MAS],ax 
    inc EBX
    loop cycle7

    pop RDX
    pop RCX
    INC RDX
    loop cycle

    mov EDX,0
    mov EBX,0
    mov ECX,5
    cycle3:

    push RCX
    mov AX,0
    mov ECX,4
    cycle4:
    add AX,[EBX*2+MAS]
    inc EBX
    loop cycle4
    mov [EDX*2+RESM],AX
    inc EDX
    pop RCX
    loop cycle3


    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, ExitMsg ; адрес выводимой строки
    mov rdx, lenExit; длина строки
    syscall
    
    mov EDX,0
    mov EBX,0
    mov ECX,5
    cycle2:
    push RCX
    push RDX

    mov AX,0
    cmp AX,[EDX*2+RESM]
    je  deleted


    mov ECX,4
    cycle10:
    mov     esi, OutBuf  ; загрузка адреса буфера вывода 
    mov     ax, [EBX*2+MAS]      ; загрузка числа в регистр 
    cwde                 ; развертывание числа из ax в eax 
    call    IntToStr64

    mov rdx, rax; длина строки
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, OutBuf ; адрес выводимой строки
    push RCX
    syscall
    pop  RCX

    inc  EBX
    loop cycle10
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, NewLine ; адрес выводимой строки
    mov rdx, 1; длина строки
    syscall
    jmp skip
    deleted:
    add EBX,4
    skip:

    pop  RDX    
    pop  RCX
    inc  RDX
    loop cycle2


   
    ; read
    mov rax, 0; системная функция 0 (read)
    mov rdi, 0; дескриптор файла stdin=0
    mov rsi, InBuf; адрес вводимой строки
    mov rdx, lenIn; длина строки
    ; вызов системной функции
    syscall
    ; exit
    mov rax, 60; системная функция 60 (exit)
    xor rdi, rdi; return code 0
    syscall
    ; вызов системной функции
%include "../lib64.asm"