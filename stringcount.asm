    global _start		
    section .text

    _start:     
    mov eax, 4
    mov ebx, 1
    mov ecx, message

    push eax
    push ebx
    ; store strlen in ebx
    call _count
    mov [result], ebx
    mov edx, [result]

    pop ebx
    pop eax

    int 80h

    exit:    
    mov eax, 1
    mov ebx, 0
    int 80h

    _count:     
    xor eax, eax
    mov ebx, 1
    lea esi, [message]
    myloop:
    lodsb
    cmp al, 0ah
    je strlen_end
    inc ebx
    jmp myloop
    strlen_end:
    ret


    section .data
    message: db "hello, world",0ah
    result: resb 4
