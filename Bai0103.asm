;Nhap 1 ky tu
;Xuat ky tu vua truoc, sau ky tu vua nhap

.model small
.stack 100h	
.data
    nhap db "Nhap ky tu: $"
    truoc db 10,13,"Ky tu truoc: $"
    sau db 10,13,"Ky tu sau: $"
    c db ?
.code
	;khoi tao ds
	mov ax,@data
	mov ds,ax
	;in ra nhap
	lea dx,nhap
	mov ah,9
	int 21h      
	;nhap ki tu
	mov ah,1
	int 21h   
	;luu ki tu vao c
	mov c,al
	;in ra truoc   
	lea dx,truoc
	mov ah,9
	int 21h
	;giam c di 1
	dec c	        
	;in ra c        
	mov ah,2
	mov dl,c
	int 21h
	;tang c them 2
	add c,2  
	;in ra sau
	lea dx,sau
	mov ah,9
	int 21h 
	;in ra c
	mov ah,2
	mov dl,c
	int 21h
	;thoat chuong trinh:
	mov ah, 4ch
	int 21h
end