;Program ASM to do a binay search for a number from a sorted list
; and display the appropriate message on the screen

.MODEL SMALL

.DATA

ARRAY DB 15 DUP (?)

M1 DB 10,'Enter elements of the array:$'
M2 DB 10,'Enter the number to be searched:$'
M3 DB 10,'Number found$'
M4 DB 10,'Number not found$'
M5 DB 10,'Enter the number of elements:$'
UL DB ?
LL DB 0H
K DB ?

.CODE

MOV AX,@data
MOV DS,AX

MOV AH,09H
MOV DX,OFFSET M5
INT 21H

MOV AH,01H
INT 21H
SUB AL,30H

MOV CL,AL
MOV UL,AL

MOV SI,0

MOV AH,09H
MOV DX, OFFSET M1
INT 21H

EnterArray:
MOV AH,01H
INT 21H
SUB AL,30H
MOV ARRAY[SI],AL
INC SI

MOV DL,20H
MOV AH,02H
INT 21H

LOOP EnterArray

MOV AH,09H
MOV DX,OFFSET M2
INT 21H

MOV AH,01H
INT 21H
SUB AL,30H
MOV K,AL

SEARCH:
MOV BL,UL
MOV DL,LL
CMP BL,DL
JC NotFound

MOV AL,BL
ADD AL,DL
MOV CL,02H
MOV AH,00H
DIV CL
MOV AH,00H
MOV BX,AX
MOV AL,ARRAY[BX]

CMP K,AL

JZ Found
JL lowArr
JG highArr

lowArr:
SUB BL,01H
MOV UL,BL
JMP SEARCH

highArr:
ADD BL,01H
MOV LL,BL
JMP SEARCH

NotFound:
MOV AH,09H
MOV DX,OFFSET M4
INT 21H
JMP ExitHere

Found:
MOV AH,09H
MOV DX,OFFSET M3
INT 21H


ExitHere:
MOV AH,4CH
INT 21H

END
