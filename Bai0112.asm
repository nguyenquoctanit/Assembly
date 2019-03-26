;Nhap ki tu
;In ra ma ascii hex,thap phan,nhi phan

prin macro s    ;macro in ra xau s
    mov ah,9
    lea dx,s
    int 21h
endm            ;ket thuc macro
    
.model small
.stack 100h
.data
    tb db "Nhap ki tu: $"
    tb1 db 10,13,"Ma Ascii dang Hex:$"
    tb2 db 10,13,"Ma Ascii dang Dec:$"
    tb3 db 10,13,"Ma Ascii dang Bin:$"
    c db ?
    he db ?
    s1 db "$$h$"
    s2 db "$$$$"
    s3 db "00000000b$"
    tem db "$$$$$$$$$"
.code     
    ;khai bao ds va es
    mov ax,@data
    mov ds,ax
    mov es,ax
    ;in ra tb
    prin tb
    ;nhap ki tu
    mov ah,1
    int 21h
    ;luu ki tu vao c
    mov c,al
    ;chuyen ma ascii cua c sang hex luu vao s1:
    ;truoc tien chuyen sang xau tem voi thu tu nguoc lai
    mov al,c        ;al=c
    lea si,tem      ;si tro den phan tu dau tien cua tem
    mov bl,16       ;so chia bl=16
    lap1:
    mov ah,0        ;gan ax=al bang cach cho ah=0
    div bl          ;ax/bl luu thuong vao al
    mov [si],ah     ;luu so du ah vao tem[si]
    add [si],48     ;chuyen so thanh ki tu bang cach +48
    cmp [si],'9'    ;so sanh tem[si] voi '9'
    ja he16         ;neu lon hon nhay den he16
    jmp boqua
    he16:           ;
    add [si],7      ;+7 de co ki tu 'A'-->'F'
    boqua:
    inc si          ;tang si
    cmp al,0        ;so sanh al voi 0
    jnz lap1        ;al!=0 thi lap tiep
    ;sau do dao xau tem roi luu vao s1
    lea di,s1       ;di tro den phan tu dau tien cua s1
    dao1:
    dec si          ;giam si
    mov bl,[si]     ;bl=tem[si]
    mov [di],bl     ;s1[di]=bl
    inc di          ;tang di
    cmp si,offset tem   ;si tro den phan tu dau cua chuoi tem chua?
    jnz dao1            ;neu chua thi quay lai dao1 tiep
    
    ;chuyen ma ascii cua c sang thap phan, luu vao s2
    ;truoc tien chuyen sang xau tem voi thu tu nguoc lai
    mov al,c        ;al=c
    lea si,tem      ;si tro den phan tu dau tien cua tem
    mov bl,10       ;so chia bl=10
    lap2:
    mov ah,0        ;gan ax=al bang cach cho ah=0
    div bl          ;chia ax/bl luu thuong vao al
    mov [si],ah     ;luu so du vao tem[si]
    add [si],48     ;chuyen so sang ki tu bang cach +48
    inc si          ;tang si
    cmp al,0        ;
    jnz lap2        ;al!=0 quay lai lap2
    ;sau do dao xau tem roi luu vao s2
    lea di,s2       ;di tro den phan tu dau tien cua s2
    dao2:
    dec si          ;giam si
    mov bl,[si]     ;bl=tem[si]
    mov [di],bl     ;s2[di]=bl
    inc di          ;tang di
    cmp si,offset tem   ;si tro ve dau chuoi tem chua?
    jnz dao2            ;neu chua lap tiep
    
    ;chuyen ma ascci cua c sang nhi phan, luu vao s3
    mov al,c        ;al=c
    lea di,s3+7     ;di tro den phan tu cuoi cung cua s3
    mov bl,2        ;so chia bl=2
    lap3:
    mov ah,0        ;gan ax=al bang cach cho ah=0
    div bl          ;ax/bl
    mov [di],ah     ;luu so du ah vao s3[di]
    add [di],48     ;chuyen so thanh ki tu bang cach +48
    dec di          ;giam di
    cmp al,0        ;
    jnz lap3        ;neu al!=0 thi lap tiep
  
    ;in ra s1
    prin tb1
    prin s1
    ;in ra s2
    prin tb2
    prin s2
    ;in ra s3
    prin tb3
    prin s3
    
    ;nhap ki tu bat ki de ket thuc:
    mov ah,7
    int 21h
    ;thoat chuong trinh
    mov ah,4ch
    int 21h
end