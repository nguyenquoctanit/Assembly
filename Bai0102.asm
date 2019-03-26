;Nhap 1 ky tu dung int 21h ngat 7       
;Khong luu ky tu vao bien
;Xuat ky tu vua nhap dung int 21h ngat 2

.model small
.stack 100h
.data
    nhap db "Nhap ky tu: $"
    xuat db 10,13,"Ky tu vua nhap: $"
.code
	;khoi tao ds
	mov ax,@data
	mov ds,ax
	;in ra chuoi nhap
	lea dx,nhap
	mov ah,9
	int 21h      
	;nhap ki tu
	mov ah,7
	int 21h 
	;luu ki tu vao bl
	mov bl,al  
	;in ra xuat   
	lea dx,xuat
	mov ah,9
	int 21h
	;in ra ki tu
	mov ah,2
	mov dl,bl
	int 21h
	;thoat chuong trinh:
	mov ah, 4ch
	int 21h
end