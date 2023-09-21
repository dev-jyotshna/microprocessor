.model small
.data
msg1 db "Enter an 8-bit binary no.: $"
msg2 db " Its equivalent ASCII characters: $"
.code
mov ax,@data
mov ds,ax
mov dx,offset msg1
mov ah,09h
int 21h
mov bl,00h
mov cl,08h ;cl count register

input_bin:
        mov ah,01h ;to read a character in AL
        int 21h
        sub AL,'0' ;or 30h
        shl bl,1
        add bl,al
        loop input_bin
mov dx,offset msg2
mov ah,09h
int 21h
mov dl,bl
mov ah,02h      ;displays a character which is in DL register
int 21h
mov ah,4ch
int 21h
end
