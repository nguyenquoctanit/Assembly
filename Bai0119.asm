;nhap 1 so,tinh tong cac chu so cua no
.model small
.stack 100h
.data
    tb db "Nhap vao so:$"
    x db 40,0,40 dup ("$")
    t dw ?
    s db 6 dup ("$")
    tem db 6 dup ("$")
    tb1 db 10,13,"Tong cac chu so:$"
.code
    ;khoi tao ds va es:
    mov ax,@data
    mov ds,ax
    mov es,ax
    
    ;in ra tb:
    mov ah,9
    lea dx,tb
    int 21h
    ;nhap chuoi x luu so thap phan:
    mov ah,10
    lea dx,x
    int 21h
    
    ;tinh tong cac chu so,ket qua luu vao t:
    mov ax,0    ;khoi tao ax=0
    lea di,x+2  ;di tro den phan tu dau tien cua x(bo qua 2 phan tu dau)
    lap:
    mov bl,[di] ;luu ki tu x[di] vao bl
    sub bl,48   ;chuyen ki tu thanh so bang cach -48
    mov bh,0    ;gan bx=bl bang cach cho bh=0
    add ax,bx   ;ax=ax+bx
    inc di      ;tang di
    cmp [di],13 ;gap enter?
    jnz lap     ;neu chua thi lap tiep
    mov t,ax
    
    ;chuyen so t sang chuoi s:
    ;truoc tien chuyen t sang chuoi tem theo thu tu nguoc
    lea si,tem  ;si tro den phan tu dau tien cua tem
    mov ax,t    ;gan ax=t
    chuyen:
    mov dx,0    ;gan so bi chia dxax=ax bang cach cho dx=0
    mov bx,10   ;gan so chia bx=10
    div bx      ;chia dxax/bx luu thuong vao ax
    mov [si],dl ;gan so du dx cho tem[si]
                ;so du dx<10 nen luon co dl=dx
    add [si],48 ;chuyen so sang ki tu bang cach +48
    inc si      ;si tro den phan tu tiep theo cua tem
    cmp ax,0    ;so sanh ax voi 0
    jnz chuyen  ;neu ax!=0 thi lap tiep
    ;sau do dao chuoi tem,luu ket qua vao chuoi s
    lea di,s            ;di tro den phan tu dau tien cua s
    dao:
    dec si              ;giam si
    mov bl,[si]         ;bl=tem[si]
    mov [di],bl         ;s[di]=bl
    inc di              ;tang di
    cmp si,offset tem   ;si tro den phan tu dau tien cua tem chua?
    jnz dao             ;neu chia thi lap tiep
    
    ;in ra tb1:
    mov ah,9
    lea dx,tb1
    int 21h
    ;in ra s:
    mov ah,9
    lea dx,s
    int 21h
    ;nhap phim bat ki de ket thuc:
    mov ah,7
    int 21h
    ;ket thuc chuong trinh:
    mov ah,4ch
    int 21h
end
    