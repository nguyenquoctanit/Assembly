;Nhap 2 so nguyen duong A,B
;Khong dung lenh div,mul tinh va in ra ket qua A/B, A*B

.model small
.stack 100h
.data
    tb1 db "Nhap 2 so nguyen duong A,B:",10,13,"A=$"
    tb2 db 10,13,"B=$"
    x db 7,0,7 dup ("$")
    y db 7,0,7 dup ("$")
    A dw 0
    B dw 0
    C dw ?
    D dw ?
    s1 db 10 dup ("$")
    s2 db 10 dup ("$")
    tem db 10 dup ("$")
    tb3 db 10,13,"A/B=$"
    tb4 db 10,13,"A*B=$"
.code           
    ;khoi tao ds va es
    mov ax,@data
    mov ds,ax
    mov es,ax
    ;in ra tb1
    mov ah,9
    lea dx,tb1
    int 21h
    ;nhap A vao chuoi x:
    mov ah,10
    lea dx,x
    int 21h
    ;in ra tb2:
    mov ah,9
    lea dx,tb2
    int 21h
    ;nhap B vao chuoi y:
    mov ah,10
    lea dx,y
    int 21h
    ;chuyen chuoi x thanh so A:
    lea di,x+2      ;di tro den phan tu dau tien cua x(bo qua 2 phan tu dau)
    mov ax,0        ;khoi tao ax=0
    lap1:
    ;nhan ax cho 10           
    mov cx,10       ;lap 10 lan
    mov bx,ax       ;bx=ax
    mov ax,0        ;khoi tao ax=0       
    Ax10:           ;
    add ax,bx       ;ax=ax+bx
    loop Ax10       ;cx>0 thi tiep tuc lap1
    
    mov bl,[di]     ;luu ki tu x[di] vao bl
    sub bl,48       ;chuyen ki tu sang so bang cach -48
    mov bh,0        ;gan bx=bl bang cach cho bh=0
    add ax,bx       ;cong bx vao ax 
    inc di          ;di tro den phan tu tiep theo
    
    cmp [di],13     ;
    jnz lap1        ;chua nhan enter thi tiep tuc lap
    
    mov A,ax        ;gan ax cho A
    
    ;chuyen chuoi y thanh so B: 
    lea di,y+2      ;di tro den phan tu dau tien cua y(bo qua 2 phan tu dau)
    mov ax,0        ;khoi tao ax=0
    lap2:
    ;nhan ax cho 10           
    mov cx,10       ;lap 10 lan
    mov bx,ax       ;bx=ax
    mov ax,0        ;khoi tao ax=0       
    Bx10:           ;
    add ax,bx       ;ax=ax+bx
    loop Bx10       ;cx>0 thi tiep tuc lap1
    
    mov bl,[di]     ;luu ki tu y[di] vao bl
    sub bl,48       ;chuyen ki tu sang so bang cach -48
    mov bh,0        ;gan bx=bl bang cach cho bh=0
    add ax,bx       ;cong bx vao ax 
    inc di          ;di tro den phan tu tiep theo
    
    cmp [di],13     ;
    jnz lap2        ;chua nhan enter thi tiep tuc lap
    
    mov B,ax        ;gan ax cho B
    
    ;Thuc hien A/B duoc thuong la C
    mov C,0     ;khoi tao thuong C=0
    mov ax,A    ;ax=A
    chia:
    cmp ax,B    ;so sanh ax voi B
    jb thoat1   ;neu ax<B thi thoat1
    sub ax,B    ;neu khong tru ax di B
    inc C       ;tang C
    jmp chia    ;nhay den nhan chia
    thoat1:
    
    ;Thuc hien A*B duoc tich la D
    mov ax,0    ;khoi tao tich ax=0
    mov cx,B    ;cx=B, lap B lan
    nhan:
    add ax,A    ;ax=ax+A
    loop nhan   ;cx>0 thi lap tiep
    mov D,ax    ;gan D=ax
    
    ;chuyen so C sang chuoi tem theo thu tu nguoc:
    lea si,tem       ;si tro den phan tu dau tien cua tem
    mov ax,C         ;ax=C
    
    Cchia10:         ;thuc hien phep chia ax/10
    mov bx,0         ;thuong luu vao bx
    lap3:
    cmp ax,10        ;so du luu vao ax
    jb ketthuc1      ;
    sub ax,10        ;
    inc bx           ;
    jmp lap3
    ketthuc1:
    mov [si],al      ;luu so du ax vao tem[di]
                     ;do ax<10 nen al=ax
    add [si],48      ;chuyen so sang ki tu bang cach +48
    
    mov ax,bx        ;gan ax= thuong
    inc si           ;si tro den phan tu tiep theo cua tem
    
    cmp ax,0         ;
    jnz Cchia10      ;neu thuong >0 thuc hien lap tiep
    
    ;dao chuoi tem roi luu vao s1
    lea di,s1       ;di tro den phan tu dau tien cua s1
    dao1:
    dec si          ;si tro den phan tu lien truoc
    
    mov bl,[si]     ;bl=tem[si]
    mov [di],bl     ;s1[di]=bl
    
    inc di          ;di tro den phan tu tiep theo cua s1
    cmp si,offset tem   ;
    jnz dao1            ;neu si chua tro den phan tu dau tien cua tem thi tiep tuc
    
    ;chuyen so D sang chuoi tem theo thu tu nguoc
    lea si,tem       ;si tro den phan tu dau tien cua tem
    mov ax,D         ;ax=D
    
    Dchia10:         ;thuc hien phep chia ax/10
    mov bx,0         ;thuong luu vao bx
    lap4:
    cmp ax,10        ;so du luu vao ax
    jb ketthuc2      ;
    sub ax,10        ;
    inc bx           ;
    jmp lap4
    ketthuc2:
    mov [si],al      ;luu so du ax vao tem[di]
                     ;do ax<10 nen al=ax
    add [si],48      ;chuyen so sang ki tu bang cach +48
    
    mov ax,bx        ;gan ax= thuong
    inc si           ;si tro den phan tu tiep theo cua tem
    
    cmp ax,0         ;
    jnz Dchia10      ;neu thuong >0 thuc hien lap tiep
    
    ;dao chuoi tem roi luu vao s2
    lea di,s2       ;di tro den phan tu dau tien cua s2
    dao2:
    dec si          ;si tro den phan tu lien truoc
    
    mov bl,[si]     ;bl=tem[si]
    mov [di],bl     ;s2[di]=bl
    
    inc di          ;di tro den phan tu tiep theo cua s2
    cmp si,offset tem   ;
    jnz dao2            ;neu si chua tro den phan tu dau tien cua tem thi tiep tuc
    
    ;in ra ket qua A/B
    mov ah,9
    lea dx,tb3
    int 21h
    lea dx,s1
    int 21h
    ;in ra ket qua A*B
    lea dx,tb4
    int 21h
    lea dx,s2
    int 21h
    
    mov ah,4ch      ;
    int 21h         ;ket thuc chuong trinh
end