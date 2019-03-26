giaithua Macro n
Local nhan
Mov bx,n
and bx,000fh
mov ax,1
nhan: mul bx
dec bx
cmp bx,1
ja nhan
EndM   
;
.model small
.stack 100h  
start:
.data
x1 db 'Nhap n = $'
x2 db 0dh, 0ah, 'N! = $'  
.code
mov ax,@data
mov ds,ax
over:
Mov ah,9
lea dx,x1
int 21h
mov ah,1
int 21h
giaithua ax
push ax
mov ah,9
lea dx,x2
int 21h
pop ax
mov bx,10
mov cx,0
chia: xor dx,dx
div bx
push dx
inc cx
cmp ax,0
ja chia
mov ah,2
inra: pop dx
or dl,30h
int 21h
loop inra
int 20h   
;
mov ah,4ch
int 21h
end 