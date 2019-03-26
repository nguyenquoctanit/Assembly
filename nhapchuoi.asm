.model small
.stack 100h
.data
tb1 db "nhap ten mot nguoi: $"
tb2 db 13, 10,"xin chao $"
str db 200,?,200 dup("$")
dw 128 dub(?)
.code

mov ax,@data
mov ds,ax 
;
lea dx,tb1
mov ah,9
int 21h
;
mov ah,0Ah
lea dx,str
int 21h
;
lea DX,tb2
mov ah,9
int 21h
;
lea bx,str
mov al,{bx+1}
mov ah,0
add bx,ax
;mov [bx+2],"$"
mov ah,9
lea dx,str+2
int 21h
;    
mov ah,4ch
int 21h
end