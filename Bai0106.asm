;Nhap ki tu thuong
;In cac ki tu cho den 'z', cac ki tu cach nhau khang trong

.model small
.stack 100h	
.data       
    s db 10,13,"Nhap ki tu thuong: $"
    c db ?
.code   
	;khoi tao ds:
	mov ax,@data
	mov ds,ax
	
	nhap:
	;in ra s:
	lea dx,s
	mov ah,9
	int 21h
	              
	;nhap ki tu:
	mov ah, 1   ;tu dong luu ki tu vua nhap vao al
	int 21h     ; 
	
	;kiem tra ki tu thuong hay khong:
	cmp al,'a'
	jb nhap     ;neu al<'a' nhap lai
	cmp al,'z'
	ja nhap     ;neu al>'z' nhap lai
	
	;luu ki tu vao c
	mov c,al
	         
	;xuong dau dong: 
	mov ah,2
	mov dl,10
	int 21h
	mov dl,13
	int 21h
	
	;in ra cac ki tu tu al den 'z':
	prin:
	mov ah,2
	mov dl,c    ;in c
	int 21h
	mov dl,' '  ;in khoang trong
	int 21h
	
	inc c       ;tang al
	cmp c,'z'   ;so sanh c voi 'z'
	jna prin    ;c<='z' thi quay lai in tiep
	
	;ket thuc chuong trinh
	mov ah, 4ch
	int 21h
end                   