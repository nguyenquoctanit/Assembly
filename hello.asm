.MODEL small
.STACK 100h
.DATA
Message db �Hello Assembly!$�
.CODE
ProgramStart:
Mov AX,@DATA
Mov DS,AX
Mov DX,OFFSET Message
Mov AH,9
Int 21h
Mov AH,4Ch
Int 21h
END ProgramStart