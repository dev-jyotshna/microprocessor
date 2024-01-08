;Program for 32-bit binary multiplication
; MUL EBX
; EDX-EAX

.model small
.386
.stack 50H
.data
d1 db 0AH,'Enter first number: ',24H
d2 db 0AH,'Enter second number: ',24H
d3 db 0AH,'Multiplication RESULT: ',24H
.code
start:
        MOV AX,@DATA
        MOV DS,AX
        MOV DX,offset d1
        MOV AH,09H
        INT 21H
        CALL Input
        MOV EBP,EBX
        MOV DX,offset d2
        MOV AH,09H
        INT 21H
        CALL Input
        MOV DX,offset d3
        MOV AH,09H
        INT 21H
        MOV EAX,EBP

        MUL EBX

        MOV EBX,EDX
        MOV ESI,EAX

        CALL Output
        
	  MOV EBX,ESI

        CALL OUTPUT
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
        CMP AL,39H
        JBE L2
        SUB AL,37H
        JMP L3
L2:
        SUB AL,30H
L3:
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
L4:
        MOV EBP,0F0000000H
        MOV CL,1CH
        MOV CH,08H
L5:
        MOV EDX,EBX
        AND EDX,EBP
        SHR EDX,CL
        CMP DL,09H
        JBE L6
        ADD DL,37H
        JMP L7
L6:
        ADD DL,30H
L7:
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

