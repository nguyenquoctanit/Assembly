;Nhap 2 chuoi so s1, s2 roi chuyen thanh so N1,N2
;tinh tong N=N1+N2 roi chuyen N sang chuoi S
;xuat S
.model small
.stack 100h
.data
    tb1 db "Nhap N1=$"
    tb2 db 10,13,"Nhap N2=$"
    s1 db 6,0,6 dup ("$")
    s2 db 6,0,6 dup ("$")
    s db 6 dup ("$")
    tem db 6 dup ("$")
    N1 dw 0  ;so1
    N2 dw 0  ;so2
    N dw 0   ;tong
    x db 10,13,"N=N1+N2=$"
.code        
    ;khoi tao ds va es:
    mov ax,@data
    mov ds,ax
    mov es,ax
    ;in ra tb1:
    mov ah,9
    lea dx,tb1 
    int 21h
    ;nhap chuoi s1
    mov ah,10 ;0ah
    lea dx,s1
    int 21h
    ;in ra tb2
    mov ah,9
    lea dx,tb2
    int 21h
    ;nhap chuoi s2
    mov ah,10
    lea dx,s2
    int 21h
    
    ;chuyen chuoi S1 sang so N1:
    lea di,s1+2     ;di tro den phan tu dau tien cua s1(bo qua 2 phan tu dau tien)
    lap1:
    mov ax,N1       ;ax=N1
    mov bx,10       ;bx=10
    mul bx          ;nhan ax*bx tich luu vao dxax
                    ;o day chi xet so word nen luon co dx=0
    mov N1,ax       ;N1=ax
    mov bl,[di]     ;luu ki tu s1[di] vao bl
    sub bl,48       ;chuyen ki tu sang so bang cach -48       
    add N1,bx      ;cong them bl vao N1, o day bl<10 nen bx=bl
    inc di          ;tang di
    cmp [di],13     ;gap enter chua?
    jnz lap1        ;neu chua tiep tuc lap1

    ;chuyen chuoi S2 sang so N2:
    lea di,s2+2     ;di tro den phan tu dau tien cua s2(bo qua 2 phan tu dau tien)
    lap2:
    mov ax,N2       ;ax=N2
    mov bx,10       ;bx=10
    mul bx          ;nhan ax*bx tich luu vao dxax
                    ;o day chi xet so word nen luon co dx=0
    mov N2,ax       ;N2=ax
    mov bl,[di]     ;luu ki tu s2[di] vao bl
    sub N2,48       ;chuyen ki tu sang so bang cach -48
    add N2,bx       ;cong them bl vao N2, o day bl<10 nen bx=bl       
    inc di          ;tang di
    cmp [di],13     ;gap  enter chua?
    jnz lap2        ;neu chua tiep tuc lap2
    
    ;N=N1+N2
    mov ax,N1
    add ax,N2
    mov N,ax

    ;chuyen N sang chuoi tem theo chieu nguoc lai
    lea si,tem          ;si tro den dia chi cua tem
    mov ax,N            ;ax=N
    chuyen:
    mov dx,0            ;gan dxax=ax bang cach cho dx=0
    mov bx,10           ;so chia bx=10
    div bx              ;thuc hien phep chia dxax/bx thuong luu vao ax
    mov [si],dl         ;luu so du dx vao tem[si]
                        ;dx<10 nen luon co dl=dx
    add [si],48         ;chuyen so sang ki tu bang cach +48
    inc si              ;tang si
    cmp ax,0            ;
    jnz chuyen          ;neu ax>0 thi thuc hien tiep
    
    ;dao chuoi tem ta co chuoi S
    lea di,s            ;di tro toi phan tu dau tien cua s
    dao:              
    dec si              ;giam si
    mov bl,[si]         ;bl=tem[si]
    mov [di],bl         ;gan s[di]=bl
    
    inc di              ;tang di              
    cmp si,offset tem   ;si tro den phan tu dau tien cua tem?
    jnz dao             ;neu chua tiep tuc thuc hien 
    
    ;in ra xau S
    mov ah,9
    lea dx,x
    int 21h
    lea dx,s
    int 21h                      
    
    ;nhan phim bat ki de ket thuc:
    mov ah,7
    int 21h
    
    mov ah,4ch
    int 21h
end                