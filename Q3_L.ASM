.model small

.data
arr db 10 dup(?)
arr_size db 0
elem db 0

msg1 db "Enter the number of elements: $"
msg2 db " Enter the elements: $"
msg3 db " Enter the element to be searched: $"
msg4 db " Element found!$"
msg5 db " Element not found!$"

.code
mov ax,@data
mov ds,ax
mov dx,offset msg1
mov ah,09h
int 21h

;To read number of elements(a character )
mov ah,01h
int 21h
sub al,30h
mov arr_size,al
mov cl,arr_size

;creating array
mov si,0
mov dx,offset msg2
mov ah,09h
int 21h

array_elements:
        mov ah,01h                             ;to read a character
        int 21h
        sub al,30h
        mov arr[si],al
        inc si
        loop array_elements

;searching for element in the array
mov dx,offset msg3
mov ah,09h                                     ; display
int 21h

mov ah,01h                                  ; read a character in elem label
int 21h
sub al,30h
mov elem,al
mov si,0
mov cl,arr_size
mov bl,elem

Linear_search:
       cmp arr[si],bl
       jz found
       inc si
       loop Linear_search

notfound:
        mov dx,offset msg5
        mov ah,09h
        int 21h
        jmp here

;Print if element is found
found:
mov dx,offset msg4
mov ah,09h
int 21h

here:
mov ah,4ch
int 21h                   ;successful termination
end
