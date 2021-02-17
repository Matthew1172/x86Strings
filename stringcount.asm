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

;we need these 3 registers in _count
;so we push them to the stack for later
push eax
push ebx
push esi

;load address of string into esi
;for _count function
lea esi, [message]
;_count will store strlen in eax
call _count
;move the strlen from eax into result
mov [result], eax
;move result into edx for stdout
mov edx, [result]

;pop each register used in _count
;in reverse order
pop esi
pop ebx
pop eax

;print to stdout
int 80h

;walk into exit
exit:
mov eax, 1
mov ebx, 0
;return to bash
int 80h

;_count function requires the string
;to count loaded into esi and will return
;with the length of the string in ebx
;using newline terminating string or 0a
_count:
;zero out eax
xor eax, eax
;start count of string to be 1
;to include newline charater at end of string
mov ebx, 1
;start counting loop
myloop:
;load a string byte into eax from esi
lodsb
;compare the string byte with the newline ascii hex
cmp al, 0ah
;if they are equal, jump to return point
je strlen_end
;else, increment the count stored in ebx
;then jump back to counting loop
inc ebx
jmp myloop
strlen_end:
mov eax, ebx
ret

section .data
message: db "Matthew Pecko 23916868 32178",0ah

section .bss
result: resb 4
