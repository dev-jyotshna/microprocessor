;Program for 32-bit BCD subtraction 
.model small
.386
.data
d1 db 0AH,'Enter the first number :',24H
d2 db 0AH,'Enter the second number :',24H
d3 db 0AH,'Difference is  :',24H

num1 dd ?
num2 dd ?
num3 dd ?

.code
start:
 MOV AX,@data
 MOV DS,AX

 MOV DX,offset d1
 MOV AH,09H
 INT 21H
 CALL Input
 MOV SI,offset num1
 MOV [SI],EBX

 MOV DX,offset d2
 MOV AH,09H
 INT 21H
 CALL Input
 MOV SI,offset num2
 MOV [SI],EBX

MOV CL,04H
MOV CH,00H
MOV DI,offset num1
MOV SI,offset num2
MOV BX,offset num3
CLC

BCDSUB:
       MOV DL,[SI]
       MOV AL,[DI]
       SBB AL,DL
       DAS
       MOV [BX],AL
       INC SI
       INC DI
       INC BX
LOOP BCDSUB
MOV EBX,num3

 MOV DX,offset d3
 MOV AH,09H
 INT 21H
 CALL Output
 MOV AH,4CH
 INT 21H



Input PROC NEAR
 MOV EBX,00000000H
 MOV EDX,00000000H
 MOV CL,1CH
 MOV CH,08H
L1:
 MOV AH,01H
 INT 21H

 SUB AL,30H
 MOV DL,AL
 SHL EDX,CL
 ADD EBX,EDX
 MOV EDX,00000000H
 SUB CL,04H
 SUB CH,01H
 JNZ L1
 RET
Input ENDP


Output PROC NEAR
 JNC L4
 MOV DL,31H
 MOV AH,02H
 INT 21H
L4:
 MOV EBP,0F0000000H
 MOV CL,1CH
 MOV CH,08H
L5:
 MOV EDX,EBX
 AND EDX,EBP
 SHR EDX,CL
 ADD DL,30H
 MOV AH,02H
 INT 21H
 MOV AL,CL
 MOV CL,04H
 SHR EBP,CL
 MOV CL,AL
 SUB CL,04H
 SUB CH,01H
 JNZ L5
 RET
Output ENDP
end start
