;Nhap 2 so nguyen duong a,b
;Tinh va in ra uoc chung lon nhat cua a,b o dang thap phan
.model small
.stack 100h
.data
    tbA db "Nhap 2 so nguyen duong a,b",10,13,"a=$"
    tbB db 10,13,"b=$"
    a_str db 7,0,7 dup ("$")
    b_str db 7,0,7 dup ("$")
    a dw ?
    b dw ?
    ucln dw ?
    ucln_str db 6 dup ("$")
    tem db 6 dup ("$")
    tb db 10,13,"UCLN(a,b)=$"
.code
    ;khoi tao ds va es
    mov ax,@data
    mov ds,ax
    mov es,ax
    ;in ra tbA
    mov ah,9
    lea dx,tbA
    int 21h
    ;nhap a_str
    mov ah,10
    lea dx,a_str
    int 21h
    ;in ra tbB
    mov ah,9
    lea dx,tbB
    int 21h
    ;nhap b_str
    mov ah,10
    lea dx,b_str
    int 21h
    
    ;chuyen a_str sang so a
    lea di,a_str+2  ;di tro den phan tu dau tien cua a_str(bo qua 2 phan tu dau)
    mov ax,0        ;khoi tao ax=0
    convertA:
    mov bx,10       ;so nhan bx=10
    mul bx          ;nhan ax*bx ket qua luu vao dxax
                    ;o day chi xet so word nen luon co dx=0
    mov bl,[di]     ;luu ki tu a_str[di] vao bl
    sub bl,48       ;chuyen ki tu thanh so bang cach -48
    mov bh,0        ;gan bx=bl bang cach cho bh=0
    add ax,bx       ;ax=ax+bx
    inc di
    cmp [di],13     ;gap enter chua?
    jnz convertA    ;neu chua thi lap tiep
    mov a,ax        ;cuoi cung gan a=ax
     
    ;chuyen b_str sang so b
    lea di,b_str+2  ;di tro den phan tu dau tien cua b_str(bo qua 2 phan tu dau)
    mov ax,0        ;khoi tao ax=0
    convertB:
    mov bx,10       ;so nhan bx=10
    mul bx          ;nhan ax*bx ket qua luu vao dxax
                    ;o day chi xet so word nen luon co dx=0
    mov bl,[di]     ;luu ki tu a_str[di] vao bl
    sub bl,48       ;chuyen ki tu thanh so bang cach -48
    mov bh,0        ;gan bx=bl bang cach cho bh=0
    add ax,bx       ;ax=ax+bx
    inc di
    cmp [di],13     ;gap enter chua?
    jnz convertB    ;neu chua thi lap tiep
    mov b,ax        ;cuoi cung gan b=ax
    
    ;tinh ucln cua a va b:
    mov ax,a        ;gan ax=a
    mov bx,b        ;    bx=b
    cmp ax,bx       ;so sanh ax,bx
    capnhat:
    cmp ax,bx       ;so sanh ax,bx
    jnb boqua       ;neu ax>=bx thi bo qua
    mov cx,ax       ;neu khong, swap ax,bx
    mov ax,bx       ;
    mov bx,cx       ;        
    boqua:
    sub ax,bx       ;ax=ax-bx
    cmp ax,0        ;kiem tra ax=0?
    jnz capnhat     ;neu chua thi cap nhat lai ax,bx 
    mov ucln,bx     ;khi ax=0 thi bx chinh la ucln
    
    ;chuyen ucln sang ucln_str:
    ;truoc tien chuyen ucln sang tem theo chieu nguoc
    lea si,tem      ;si tro den phan tu dau tien cua tem
    mov ax,ucln     ;gan ax=ucln
    chuyen:
    mov dx,0        ;gan so bi chia dxax=ax bang cach cho dx=0
    mov bx,10       ;so chia bx=10
    div bx          ;chia dxax/bx thuong luu vao ax
    mov [si],dl     ;luu so du dx vao tem[si]
                    ;dx<10 nen ta co dl=dx
    add [si],48     ;chuyen so thanh ki tu bang cach +48
    inc si          ;tang si
    cmp ax,0        ;kiem tra ax=0?
    jnz chuyen      ;neu chua thi lap tiep
    ;sau do dao nguoc tem thu duoc ucln_str
    lea di,ucln_str     ;di tro den phan tu dau tien cua ucln_str
    dao:
    dec si              ;giam si
    mov bl,[si]         ;bl=tem[si]
    mov [di],bl         ;ucln_str[di]=bl
    inc di              ;tang di
    cmp si,offset tem   ;si tro ve phan tu dau tien cua tem chua?
    jnz dao             ;neu chua thi dao tiep
    
    ;in ra ucln_str
    mov ah,9
    lea dx,tb
    int 21h
    lea dx,ucln_str
    int 21h 
    
    ;nhap phim bat ki de ket thuc:
    mov ah,7
    int 21h
    ;ket thuc chuong trinh:
    mov ah,4ch
    int 21h
end