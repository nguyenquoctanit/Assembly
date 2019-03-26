;Nhap chuoi
;Xuat ra "Xin chao"+chuoi

.model small 
.stack 100h
.data
    nhap db "Nhap ten: $"
    xuat db 10,13,"Xin chao $"
    ten db 80,0,80 dup("$")
.code
	;khoi tao ds:
	mov ax,@data
	mov ds,ax
	;in ra nhap:
	lea dx,nhap
	mov ah,9
	int 21h              
	;nhap chuoi ten:
	mov ah, 10
	lea dx,ten
	int 21h
	;in ra xuat:        
	mov ah,9
	lea dx,xuat
	int 21h        
	;in ra ten;        
	lea dx,ten+2         
	int 21h
	;ket thuc chuong trinh:
	mov ah, 4ch
	int 21h
end               
       