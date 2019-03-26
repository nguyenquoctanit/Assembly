;Nhap ki tu
;Xuat ra "Good morning!" neu ki tu la 'S' hoac 's'
;Xuat ra "Good Afternoon!" neu la 'T' hoac 't'
;Xuat ra "Good evening!" neu la 'C' hoac 'c'

xuat macro gd           ;dinh nghia macro xuat xuat ra chuoi gd
    lea dx,gd           ;dx luu dia chi chuoi gd
    mov ah,9            ;in chuoi co dia chi tai dx
    int 21h             ;
endm                    ;ket thuc macro

.model small
.stack 100h	
.data                        
    c db 'a'
    nhap db "Nhap ki tu: $"
    gm db 10,13,"Good morning!$"
    ga db 10,13,"Good Afternoon!$"
    ge db 10,13,"Good evening!$"
.code   
	;khoi tao ds:
	mov ax,@data
	mov ds,ax
	
	;in ra nhap:
	lea dx,nhap
	mov ah,9
	int 21h              
	
	;nhap ki tu:
	mov ah, 1
	int 21h  
	;luu ki tu vao c
	mov c,al
	
	;so sanh c voi 'S' va 's', neu bang thi nhay toi nhay1
	cmp c,'S'
	jz nhay1
	cmp c,'s'
	jz nhay1
	
	;so sanh c voi 'T' va 't', neu bang thi nhay toi nhay2
	cmp c,'T'
	jz nhay2
	cmp c,'t'
	jz nhay2
	                                       
	;so sanh c voi 'C' va 'c', neu bang thi nhay toi nhay3
	cmp c,'C'
	jz nhay3
	cmp c,'c'
	jz nhay3
	
	jmp thoat   ;nhay toi thoat
    
    nhay1: 
    xuat gm     ;in ra gm
	jmp thoat
	
	nhay2:
	xuat ga     ;in ra ga
	jmp thoat
	
	nhay3:
	xuat ge     ;in ra ge
	
	thoat:	
	;ket thuc chuong 
	mov ah, 4ch
	int 21h
end                   