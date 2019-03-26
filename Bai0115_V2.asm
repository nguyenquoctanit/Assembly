;tinh giai thua n! n>0
.model large
.stack 100h
.data
    tb db "Nhap so nguyen duong n:$"
    n_str db 6,0,6 dup ("$")
    ngt_str db 1000 dup("$")
    nho dw 0
    diachi dw 0
    du dw 0
    muoi dw 10
    muoiba dw 13
    ngt db 1,999 dup (13)    ;mang luu cac chu so cua n! theo thu tu nguoc
    tem db 1000 dup (13)     ;mang tam luu gia tri cua ngt
    tb1 db 10,13,"n!=$"
    kl db 10,13,"Tren LY THUYET,vi dung mang de thuc hien phep nhan"
    kl1 db 10,13,"nen co the tinh giai thua cua so nguyen duong n bat ki!$"
.code
    ;khoi tao ds va es
    mov ax,@data
    mov ds,ax
    mov es,ax
    ;in ra tb
    mov ah,9
    lea dx,tb
    int 21h
    ;nhap n_str
    mov ah,10
    lea dx,n_str
    int 21h
    ;chuyen chuoi n_str sang so n va luu vao cx:
    lea di,n_str+2  ;di tro den phan tu dau tien cua n_str
    mov ax,0        ;khoi tao ax=0
    chuyen:
    mul muoi        ;ax*10,luu tich vao dxax
                    ;chi xet n word nen luon co dx=0
    mov bl,[di]     ;luu ki tu n_str[di] vao bl
    sub bl,48       ;chuyen ki tu sang so bang cach -48
    mov bh,0        ;gan bx=bl bang cach cho bh=0
    add ax,bx       ;ax=ax+bx
    inc di          ;tang di
    cmp [di],13     ;gap ki tu cret(co ma ascii=13)?
    jnz chuyen      ;neu chua thi quay lai chuyen
    mov cx,ax
       
    ;tinh n!
    mov ax,1    ;ax=1
    while:
    mov bx,ax
    cmp cx,1    
    ja hon1     
    jmp endwhile    ;cx<=1 thi thoat
    hon1:
    mul cx      ;ax*cx tich luu vao dxax
    cmp dx,0
    jz chuaqua  ;neu tich<=2byte thi den chuaqua
    ;neu ax vuot qua 2 byte thi cap nhat ngt:
    ;gan tem=ngt dong thoi ngt=0
    lea si,ngt
    lea di,tem
    saochep:
    mov al,[si] ;al=ngt[si]
    mov [di],al ;tem[di]=al
    mov [si],0
    inc si
    inc di
    cmp [si],13 ;13 la ki hieu ket thuc mang
    jnz saochep ;neu chua ket thuc thi saochep tiep
    ;cap nhat ngt+=tem*bx theo thuat toan
    mov diachi,offset ngt
    capnhat:
    ;ax=bx%10, bx/=10:
    mov ax,bx
    mov dx,0
    div muoi
    mov bx,ax
    mov du,dx
    ;ngt+=du*tem*10^x
    lea si,tem
    mov di,diachi
    mov nho,0
    nhan:
    mov al,[di]
    mov ah,0
    mov dx,0
    div muoiba
    mov ax,du
    mul byte ptr [si]
    add ax,nho
    add ax,dx
    
    mov dx,0
    div muoi
    mov [di],dl
    mov nho,ax
    
    inc si
    inc di 
    cmp [si],13
    jnz nhan
    
    conho:
    cmp nho,0
    jz hetnho
    mov al,[di]
    mov ah,0
    mov dx,0
    div muoiba
    mov ax,dx
    add ax,nho
    mov dx,0
    div muoi
    mov nho,ax
    mov [di],dl
    inc di
    jmp conho
    hetnho:
    inc diachi
    cmp bx,0
    jnz capnhat
    mov ax,cx
    chuaqua:
    dec cx
    jmp while
    endwhile:
    
    ;gan tem=ngt
    lea si,ngt
    lea di,tem
    saochep_:
    mov al,[si] ;al=ngt[si]
    mov [di],al ;tem[di]=al
    mov [si],0
    inc si
    inc di
    cmp [si],13 ;13 la ki hieu ket thuc mang
    jnz saochep_ ;neu chua ket thuc thi saochep tiep
    ;cap nhat ngt+=tem*bx theo thuat toan
    mov diachi,offset ngt
    capnhat_:
    ;ax=bx%10, bx/=10:
    mov ax,bx
    mov dx,0
    div muoi
    mov bx,ax
    mov du,dx
    ;ngt+=du*tem*10^x
    lea si,tem
    mov di,diachi
    mov nho,0
    nhan_:
    mov al,[di]
    mov ah,0
    mov dx,0
    div muoiba
    mov ax,du
    mul byte ptr [si]
    add ax,nho
    add ax,dx
    
    mov dx,0
    div muoi
    mov [di],dl
    mov nho,ax
    
    inc si
    inc di 
    cmp [si],13
    jnz nhan_
    
    conho_:
    cmp nho,0
    jz hetnho_
    mov al,[di]
    mov ah,0
    mov dx,0
    div muoiba
    mov ax,dx
    add ax,nho
    mov dx,0
    div muoi
    mov nho,ax
    mov [di],dl
    inc di
    jmp conho_
    hetnho_:
    inc diachi
    cmp bx,0
    jnz capnhat_
           
    ;chuyen mang ngt sang chuoi ngt_str
    lea si,ngt
    tangsi:
    inc si
    cmp [si],13
    jnz tangsi  ;khi thoat si tro den lien sau phan tu cuoi cung cua ngt
    
    lea di,ngt_str
    lap:
    dec si
    mov al,[si]
    add al,48   ;+48 de chuyen so sang ki tu
    mov [di],al
    inc di
    cmp si,offset ngt
    jnz lap
    
    ;in ra ngt_str
    mov ah,9
    lea dx,tb1
    int 21h
    lea dx,ngt_str
    int 21h
    ;in ra ket luan
    mov ah,9
    lea dx,kl
    int 21h
    ;nhap phim bat ki de ket thuc
    mov ah,7
    int 21h
    ;ket thuc chuong trinh:
    mov ah,4ch
    int 21h
end