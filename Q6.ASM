.model small
.data
msg1 db "Enter any ASCII character: $"
msg2 db " Its binary equivalent: $"
.code
mov ax,@data
mov ds,ax
mov dx,offset msg1
mov ah,09h         ;to display a string
int 21h

mov ah,01h         ;to read a character
int 21h
mov bl,al
mov dx,offset msg2
mov ah,09h
int 21h
mov cl,08h

bin_conv:
        shl bl,1
        JC display1

display0:
        mov dl,30h
        jmp display

display1:
        mov dl,31h
display: mov ah,02h     ;to write a character
        int 21h         ;21h general purpose dispatcher
loop bin_conv
mov ah,4ch
int 21h
end
