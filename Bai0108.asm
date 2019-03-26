;Nhap chuoi bat ki
;Thay ki tu hoa bang ki tu thuong, in ra
;Thay ki tu thuong bang ki tu hoa, in ra

.model small
.stack 100h
.data
    tb db "Nhap chuoi: $"
    s db 100,0,100 dup ("$")
    s1 db 100 dup ("$")
    s2 db 100 dup ("$")
    x1 db 10,13,'$'
    x2 db " - $"
.code
    ;khoi tao ds va es
    mov ax,@data
    mov ds,ax
    mov es,ax
    ;in ra chuoi tb
    lea dx,tb
    mov ah,9
    int 21h
    ;nhap chuoi s
    lea dx,s                       
    mov ah,10
    int 21h
    
    ;ham doi ki tu hoa thanh ki tu thuong:
    lea si,s+2      ;si tro den phan tu dau tien cua s(bo qua 2 phan tu dau tien)
    lea di,s1       ;di tro den phan tu dau tien cua s1
    lap1:
    mov bl,[si]     ;gan s1[i]=bl
    mov [di],bl     ;s[i]=bl
    
    cmp [di],'A'    ;kiem tra xem co phai ki tu hoa khong
    jb boqua1       ;
    cmp [di],'Z'    ;
    ja boqua1       ;neu khong thi bo qua
    add [di],32     ;neu phai thi doi thanh ki tu thuong
    boqua1:
                    
    inc di          ;tang con tro phan tu moi chuoi
    inc si          ;
    
    cmp [si],13     ;neu chua gap enter thi lap
    jnz lap1        ;
    
    ;ham doi ki tu thuong thanh ki tu hoa:
    lea si,s+2      ;si tro den phan tu dau tien cua s(bo qua 2 phan tu dau tien)          
    lea di,s2       ;di tro den phan tu dau tien cua s2
    lap2:
    mov bl,[si]     ;gan s2[i]=bl
    mov [di],bl     ;s[i]=bl
    
    cmp [di],'a'    ;kiem tra xem co phai ki tu thuong khong
    jb boqua2       ;
    cmp [di],'z'    ;
    ja boqua2       ;neu khong thi bo qua
    sub [di],32     ;neu phai thi doi thanh ki tu hoa
    boqua2:
                    
    inc di          ;tang con tro phan tu moi chuoi
    inc si          ;
    
    cmp [si],13     ;neu chua gap enter thi lap
    jnz lap2        ;
    
    ;in ra chuoi ki tu thuong:
    mov ah,9 
    lea dx,x1
    int 21h 
    lea dx,s1
    int 21h
    ;in ra chuoi ki tu hoa:
    lea dx,x2
    int 21h
    lea dx,s2
    int 21h
    ;an phim bat ki de ket thuc:
    mov ah,7        
    int 21h
    
    mov ah,4ch      ;ket thuc chuong trinh
    int 21h         ;
end