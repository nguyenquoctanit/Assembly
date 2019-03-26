.MODEL SMALL
.STACK 100h
.DATA
Msg1 DB 'Nhap vao ki tu hoa : $'
Msg2 DB 0Dh,0Ah,'Chuyen sang ki tu thuong la : '
Char DB ?,'$'
.CODE
Main PROC
MOV AX,@DATA
MOV DS,AX
; In ra thong bao 1
LEA DX,Msg1
MOV AH,9
INT 21h
; Nhap vao 1 ki tu hoa va doi thanh ki tu thuong
MOV AH,1
INT 21h ; Doc 1 ki tu hoa va luu vao AL
ADD AL,20h ; Doi thanh ki tu thuong
MOV Char,AL
; Hien len chu thuong
LEA DX,Msg2
MOV AH,9
INT 21h
; Ket thuc chuong trinh
MOV AH,4Ch
INT 21h
Main ENDP
END Main