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

;we need these 2 registers in _count
;so we push them to the stack for later
push eax
push ecx

push message

;_count will store strlen in eax
call _strlen2
add esp, 4

;move the strlen from eax into result
mov [result], eax
;move result into edx for stdout
mov edx, [result]

;pop each register used in _count
;in reverse order
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



_strlen2:
push ebp
mov ebp, esp
sub esp, 4
push edi
push esi

xor ecx, ecx
mov edi, [ebp+8]
not ecx
xor al,al
cld
repne scasb
not ecx
lea eax, [ecx - 1]

pop esi
pop edi
mov esp, ebp
pop ebp
ret





_strlen:
;preserve edi
push edi
;load the address of the string into edi
;so we can use scan string byte instruction
lea edi, [message]
;zero out our counter ecx. repeat not equal instruction will
;decrement ecx after each increase in edi. 
xor ecx, ecx
;using 0 terminating string, we will repeat scan string byte
;instruction until the data is equal to al which is zero.
xor al, al
;flip all bits in ecx
not ecx
;clear the data's directional flag
cld
;repeat the scan string byte instruction until it equals al
repne scasb
;flip all the bits in ecx and decrement it by one to get absolute
;value of ecx
not ecx
;leave out the zero terminating byte at the end of string
dec ecx

mov eax, ecx
;restore edi
pop edi
ret


section .data
message: db "Matthew Pecko 23916868 32178",0ah

section .bss
result: resb 4
