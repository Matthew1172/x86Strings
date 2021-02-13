global _start		
section .text

_start:     
push eax
push 01h
push 02h
push 03h
call myfunc
add esp, 12
mov [result], eax
pop eax

int 80h

exit:	    
mov eax, 1
mov ebx, 0
int 80h

myfunc:
;prologue
push ebp
mov ebp, esp
sub esp, 4
push edi
push esi

;subroutine body
mov eax, [ebp+8]
mov esi, [ebp+12]
mov edi, [ebp+16]

mov [ebp-4], edi
add [ebp-4], esi
add eax, [ebp-4]

;subroutine epilogue
pop esi
pop edi
mov esp, ebp
pop ebp
ret

section .bss
result: resb 4
