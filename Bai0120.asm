;kiem tra 1 so co phai la so hoan hao hay khong
.model small
.stack 100h
.data
    tb db "Nhap so nguyen duong:$"
    n_str db 7,0,7 dup ("$")
    n dw ?
    su dw ?
    tb1 db " khong"
    tb2 db " la so hoan hao$"
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
    
    ;chuyen chuoi n_str sang so n
    lea di,n_str+2  ;di tro den phan tu dau tien cua n_str(bo qua 2 phan tu dau)
    mov ax,0        ;khoi tao ax=0
    chuyen:
    mov bx,10   ;so nhan bx=10
    mul bx      ;nhan ax*bx luu ket qua vao dxax
                ;o day chi xet so word nen luon co dx=0
    mov bl,[di] ;luu ki tu n_str[di] vao bl
    sub bl,48   ;chuyen ki tu thanh so bang cach -48
    mov bh,0    ;gan bx=bl bang cach cho bh=0
    add ax,bx   ;ax=ax+bx
    inc di      ;tang di
    cmp [di],13 ;kiem tra xem di tro den cuoi n_str chua
    jnz chuyen  ;neu chua thi quay lai chuyen
    mov n,ax    ;cuoi cung gan n=ax
    
    ;tinh tong cac uoc nho hon n:
    mov bx,0    ;khoi tao tong cac uoc bx=0
    mov cx,1    ;khoi tao uoc dau tien cx=1
    kiemTraUoc:
    mov ax,n    ;gan ax=n
    cmp cx,n    ;kiem tra cx
    jnb thoat   ;neu cx>=n thi thoat
    mov dx,0    ;gan dxax=ax bang cach cho dx=0
    div cx      ;chia dxax/cx
    cmp dx,0    ;kiem tra so du dx
    jnz boqua   ;neu khac 0 th bo qua
    add bx,cx   ;neu dx=0,cx la uoc cua n, cong them cx vao bx
    boqua:
    inc cx      ;tang cx
    jmp kiemTraUoc  ;quay kiem tra bx co phai la uoc cua n?
    thoat:
    mov su,bx 
    
    ;kiem tra co phai so hoan hao khong:
    lea di,tb1  ;di tro den tb1
    mov ax,su   ;
    cmp ax,n    ;so sanh su,n
    jnz xong    ;neu su!=n thi ket thuc
    lea di,tb2  ;neu su=n nhau thi di tro den tb2
    xong:
    
    ;in ra ket qua
    mov ah,9
    mov dx,di
    int 21h
    
    ;nhap phim bat ki de ket thuc:
    mov ah,7
    int 21h
    ;ket thuc chuong trinh:
    mov ah,4ch
    int 21h
end