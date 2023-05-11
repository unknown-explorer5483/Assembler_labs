   section .data

EntrMsga db "Enter a:",10
lenEntra equ $-EntrMsga

EntrMsgb db "Enter b:",10
lenEntrb equ $-EntrMsgb

EntrMsgq db "Enter q:",10
lenEntrq equ $-EntrMsgq

ExitMsg db "Answer:",10
lenExit equ $-ExitMsg

    section .bss

InBuf   resb    10 
lenIn   equ     $-InBuf
OutBuf  resb    10
lenOut  equ     $-OutBuf 

X       resw    1

A       resw    1
B       resw    1
Q       resw    1

    section .text 
    global _start
_start:

    mov rax, 1
    mov rdi, 1
    mov rsi, EntrMsga 
    mov rdx, lenEntra 
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, InBuf
    mov rdx, lenIn
    syscall
    mov     esi,InBuf  
    call    StrToInt64
    cmp     EBX, 0   
    jne     StrToInt64.Error 
    mov     [A],ax  

    mov rax, 1
    mov rdi, 1
    mov rsi, EntrMsgb 
    mov rdx, lenEntrb 
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, InBuf
    mov rdx, lenIn
    syscall
    mov     esi,InBuf  
    call    StrToInt64
    cmp     EBX, 0   
    jne     StrToInt64.Error 
    mov     [B],ax  

    mov rax, 1
    mov rdi, 1
    mov rsi, EntrMsgq 
    mov rdx, lenEntrq 
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, InBuf
    mov rdx, lenIn
    syscall
    mov     esi,InBuf  
    call    StrToInt64
    cmp     EBX, 0   
    jne     StrToInt64.Error 
    mov     [Q],ax      
  

    mov    BX,[A] 
    sub    BX,[B]
    cmp    BX,0
    jle    else
    mov    BX,[A]
    mov    AX,BX
    mov    ECX,2
    loopmul:
    imul   BX
    loop loopmul
    mov    CX,AX
    mov    AX,BX
    mov    BX,2
    imul   BX
    mov    BX,[Q]
    imul   BX
    sub    CX,AX
    mov    BX,[B]
    mov    AX,BX
    imul   BX
    add    CX,AX
    mov    AX,CX
    jmp    end
    else:
    mov    AX,BX
    imul   BX
    imul   BX
    mov    BX,-2
    idiv   BX
    end:
    mov    [X],AX


    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, ExitMsg ; адрес выводимой строки
    mov rdx, lenExit; длина строки
    syscall

    mov     esi, OutBuf  ; загрузка адреса буфера вывода 
    mov     ax, [X]      ; загрузка числа в регистр 
    cwde                 ; развертывание числа из ax в eax 
    call    IntToStr64



    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, OutBuf ; адрес выводимой строки
    mov rdx, lenOut ; длина строки
    mov rax, 1; системная функция 1 (write)
    ; вызов системной функции
    syscall
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