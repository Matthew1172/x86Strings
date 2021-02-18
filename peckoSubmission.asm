;Matthew Pecko
;Professor Peng
;CSc 211 Homework 1
;2/18/2021
;
;instructions:
;nasm -f elf peckoSubmission.asm 
;ld -m elf_i386 peckoSubmission.o -o ps
;./ps

global _start		
section .text
_start: 
;system call for write
mov eax, 4
;stdout
mov ebx, 1
;move address of string to print
;into register ecx
mov ecx, message

;we need these 2 registers
;so we push them to the stack for later
push eax
push ecx

;we pass the const char* string parameter on stack
push message
;this function will store strlen in eax
call _strlen
;remove string address from stack
add esp, 4

;move the strlen from eax into result
mov [result], eax
;move result into edx for stdout
mov edx, [result]

;pop each register used in reverse order
pop ecx
pop eax

;print to stdout
int 80h

;walk into exit
exit:
mov eax, 1
mov ebx, 0
;return to bash
int 80h

_strlen:
;preserve stack base pointer
push ebp
;change the base pointer to the current stack pointer
mov ebp, esp
;preserve edi and esi because we will use them
push edi
push esi

;we will not use a local variable to store length
;instead we will use ecx register, so we set it to 0
xor ecx, ecx
;move argument one into edi
mov edi, [ebp+8]
;flip all the bits in ecx to get largest possible
;32-bit integer or ecx = -1
not ecx
;make al zero, so that the repeat instruction can stop when the
;string byte is equal to the zero terminating byte.
xor al,al
;clear the data direciton flag so we can increment edi
cld
;repeat scan string byte until the string byte in edi is equal to al
;and will decrement ecx every time edi is incremented including the last byte
repne scasb
;once done, we can flip all the bits of ecx to get the 
;absolute value of the number minus 1, which is the length of the string
not ecx
;load the value of ecx minus 1 into eax return register
lea eax, [ecx - 1]

;restore esi and edi
pop esi
pop edi
;remove all local variables regardless of amount and size
;restore the stack pointer by using the base pointer
mov esp, ebp
;restore ebp
pop ebp
;return to caller
ret

section .data
message: db "Matthew Pecko 23916868 32178",0ah

section .bss
result: resb 4
