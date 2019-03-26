;Nhap chuoi khong dung 21h ngat 10
;In ra chuoi nhan duoc
;Dem va in ra so ki tu cua chuoi

.model small
.stack 100h	
.data 
    s db "Nhap chuoi: $"
    x db "==>So ki tu trong chuoi la $"    
    c db 100 dup ("$")
    tem db "$$$$"
    dem db "$$$$"
.code
    ;khoi tao ds va es   
	mov ax,@data
	mov ds,ax
	mov es,ax
	;in ra s
	lea dx,s
	mov ah,9
	int 21h
    ;nhap lan lan cac ki tu
	lea di,c    ;di tro den dia chi cua c
	xor bx,bx   ;dem so ki tu chuoi, ban dau =0
		            
	mov ah,1
	int 21h
	
	nhap:	         
	cmp al,13   ;enter?
	jz thoat    ;dung!thoat
	
	cmp al,8    ;backspace?
	jnz luu     ;khong!luu ki tu vao chuoi
	
	dec di      ;dung!lui con tro chuoi
	dec bx      ;giam bo dem so ki tu
	jmp doc     ;doc ki tu khac
	
	luu:
	mov [di],al
	inc di
	inc bx 
	
	doc:
	int 21h
	jmp nhap
	
	thoat:
	mov [di],'$'
	;xuong dong:
	mov ah,2
	mov dl,10
	int 21h
	;in ra c
	mov dx,offset c
	mov ah,9
	int 21h
	;in ra x
	mov dx,offset x
	int 21h
	
    ;ham convert bx sang chuoi dem:
    ;truoc tien convert bx sang chuoi tem voi thu tu nguoc
    lea di,tem  ;di tro den phan tu dau tien cua tem    
	mov ax,bx   ;gan ax=bx
	chuyen:
	mov bl,10   ;so chia bl=10
	div bl      ;chia ax/bl thuong luu vao al
	mov [di],ah ;gan so du ah cho tem[di]
	add [di],48 ;chuyen so thanh ki tu bang cach +48
	inc di      ;tang di
	mov ah,0    ;gan ax=al bang cach cho ah=0
	cmp al,0    ;so sanh thuong al voi 0
	jnz chuyen  ;neu chua bang thi quay lai
	;sau do dao nguoc chuoi tem,luu vao dem
	lea si,dem  ;si tro den phan tu dau tien cua dem
	dao:
	dec di      ;giam di
	mov bl,[di] ;bl=tem[di]
	mov [si],bl ;dem[si]=bl
	inc si      ;tang si
	cmp di,offset tem   ;di tro den phan tu dau tien cua tem chua?
	jnz dao             ;neu chua thi tiep tuc dao
    
    ;in	ra dem
	mov ah,9
	lea dx,dem
	int 21h
    ;ket thuc chuong trinh:	
	mov ah, 4ch
	int 21h
end                   