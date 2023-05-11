   section .data

ExitMsg db "Answer:",10 
lenExit equ $-ExitMsg

EnterMsg db "Ender string:",10 
lenEnter equ $-EnterMsg


wordsLenOut equ 19
wordsLenIn equ 19

    section .bss

words  resb 19
symbuf resb 1


    section .text 
    global _start
_start:

    mov rax, 1
    mov rdi, 1
    mov rsi, EnterMsg
    mov rdx, lenEnter

    syscall

    ; read
    mov rax, 0
    mov rdi, 0
    mov rsi, words
    mov rdx, wordsLenIn

    syscall


    mov RCX,1
    lea RDI,[symbuf]
    lea RSI,[words]
    rep movsb

    mov RCX,5
    lea RDI,[words]
    lea RSI,[words+1]
    rep movsb

    mov RCX,6
    lea RDI,[words+4]
    lea RSI,[words+6]
    rep movsb

    mov RCX,6
    lea RDI,[words+9]
    lea RSI,[words+12]
    rep movsb

    mov RCX,1
    lea RDI,[words+17]
    lea RSI,[symbuf]
    rep movsb

    mov BYTE[words+16],32
    mov BYTE[words+15],32

    mov rax, 1
    mov rdi, 1
    mov rsi, words
    mov rdx, wordsLenOut

    syscall

    mov rax, 60; системная функция 60 (exit)
    xor rdi, rdi; return code 0
    syscall

