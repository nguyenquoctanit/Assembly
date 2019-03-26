.MODEL small
.STACK 100h
.DATA
Tbao1 db "Chao mung ban den voi Assembly$"
Tbao2 db 0DH,0AH,"Assembly that de!$"
.CODE
ProgramStart:
Mov AX,@DATA
Mov DS,AX
;xuat thong bao 1
Lea DX,Tbao1
Mov AH,9
Int 21h
;xuat thong bao 2
Lea DX,Tbao2
Mov AH,9
Int 21h
Mov AH,4Ch
Int 21h
END ProgramStart
