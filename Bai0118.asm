;nhap vao day so va tinh trung binh cong cua day so do
.model small
.stack 100h
.data
    tb db "Nhap vao day so:$"
    s db 100,0,100 dup ("$")
    n db ?
    tbc dw ?
    x db 7 dup ("$")
    tem db 7 dup ("$")
    tb1 db 10,13,"Trung binh cong cua day so=$"
.code
    ;khoi tao ds vs es
    mov ax,@data
    mov ds,ax
    mov es,ax
    
    ;in ra tb
    mov ah,9
    lea dx,tb
    int 21h
    ;nhap chuoi s luu day so
    mov ah,10
    lea dx,s
    int 21h
    
    ;tinh tong day so,dem so phan tu cua day:
    lea di,s+2  ;di tro den phan tu dau tien cua s(bo qua 2 ki tu dau)
    mov tbc,0   ;khoi tao tong=0
    mov n,0     ;khoi tao so so hang =0
    ;loai bo khoang trong neu co
    kiemtrakhoangtrong:
    cmp [di],' ';so sanh s[di] voi khoang trong
    jnz boqua   ;neu khong phai thi boqua
    inc di      ;neu phai thi tang di
    jmp kiemtrakhoangtrong  ;dong thoi quay lai kiem tra tiep
    boqua:
    cmp [di],13 ;neu gap enter thi thoat
    jz thoat    ;
    ;chuyen chuoi thanh so,luu vao ax
    mov ax,0    ;khoi tao ax=0
    inc n       ;tang bien dem so so hang
    luuso:
    mov bx,10   ;so nhan bx=10
    mul bx      ;nhan ax*bx,luu ket qua vao dxax
                ;o day chi xet so kieu word nen luon co dx=0
    mov bl,[di] ;bl doc ki tu s[di]
    sub bl,48   ;chuyen ki tu thanh chuoi bang cach -48
    mov bh,0    ;gan bx=bl bang cach cho bh=0
    add ax,bx   ;ax=ax+bx
    inc di      ;tang di
    cmp [di],13     ;
    jz capnhattong  ;neu gap enter thi capnhattong
    cmp [di],' ';
    jnz luuso   ;neu chua gap khoang trong tiep tuc
    capnhattong:
    add tbc,ax
    cmp [di],13 ;
    jz thoat    ;neu gap enter thi thoat
    jmp kiemtrakhoangtrong  ;neu khong thi quay lai xoa khoang trong
    thoat: 
    ;tinh trung binh cong cua day
    mov ax,tbc  ;so bi chia ax=tbc
    mov bl,n    ;so chia bl=n
    div bl      ;chia ax/bl
    mov ah,0    ;gan ax=al bang cach cho ah=0
    mov tbc,ax
    
    ;chuyen so tbc sang chuoi x:
    ;luc dau luu tbc vao tem voi thu tu nguoc
    lea si,tem  ;si tro den phan tu dau tien cua tem
    mov ax,tbc  ;gan ax=tbc
    chuyen:
    mov dx,0    ;gan so bi chia dxax=ax bang cach cho dx=0
    mov bx,10   ;so chia bx=10
    div bx      ;chia dxax/bx thuong luu vao ax
    mov [si],dl ;gan so du dx cho tem[si]
                ;so du dx<10 nen luon co dl=dx
    add [si],48 ;chuyen so sang ki tu bang cach +48
    inc si      ;tang si
    cmp ax,0    ;kiem tra xem thuong ax=0 chua
    jnz chuyen  ;neu chua thi lap tiep
    ;dao chuoi tem ta thu duoc x
    lea di,x    ;di tro den phan tu dau tien cua x
    dao:
    dec si      ;giam si
    mov bl,[si] ;bl=tem[si]
    mov [di],bl ;x[di]=bl
    inc di      ;tang di
    cmp si,offset tem   ;kiem tra si tro ve phan tu dau tien cua tem chua
    jnz dao             ;neu chu tiep tuc dao
    ;in ra x
    mov ah,9
    lea dx,tb1
    int 21h
    lea dx,x
    int 21h
    ;nhap ki tu bat ki de ket thuc:
    mov ah,7
    int 21h
    ;ket thuc chuong trinh:
    mov ah,4ch
    int 21h
end