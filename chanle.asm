.model small             
.stack 100h
.data                         
tb1 db 10, 13, 'Nhap ki tu so kt = $'
tb2 db 10, 13, 'Do la so chan $'
tb3 db 10, 13, 'Do la so le $'
tb4 db 10, 13, 'Hay nhap lai voi  ( 0 <= kytu <= 9) $' 
.code 
;mac dinh vs main proc    
MOV AX,@DATA
MOV DS,AX
start:
nhap: 
Mov ah,9
lea dx,tb1
int 21h
mov ah,1
int 21h
mov bl,al
cmp bl,30h
jae sosanh
jmp loi
sosanh:
cmp bl,39h
jbe inra
loi: mov ah,9
lea dx, tb4
int 21h
jmp nhap
inra: Test bl,1
jne sole
mov ah,9
lea dx,tb2
jmp thoat
sole: mov ah,9
lea dx,tb3
thoat: int 21h
int 20h       
mov ah,4Ch
int 21h
end 
