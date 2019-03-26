;Nhap chuoi roi in ra chuoi nguoc
.model small
.stack 100h
.data
    tb db "Nhap chuoi:$"
    x db 100,0,100 dup ("$")
    s db 100 dup ("$")
    tb1 db 10,13,"chuoi nguoc:$"
.code
    ;khoi tao ds va es
    mov ax,@data   
    mov ds,ax      
    mov es,ax      
    ;in ra tb
    mov ah,9
    lea dx,tb
    int 21h
    ;nhap chuoi x
    mov ah,10
    lea dx,x
    int 21h
    
    ;dao chuoi x,luu ket qua vao s
    lea si,x+2      ;si tro den phan tu dau tien cua x(bo qua 2 phan tu dau)
    lap:
    inc si          ;si tro den phan tu ke tiep
    cmp [si],13     ;gap enter chua?(13 la ma ascii cua ki tu cret)
    jnz lap         ;neu chua thi quay lai tang si tiep
                    ;ket thuc vong lap si tro den ke sau phan tu cuoi cung cua x
    lea di,s            ;di tro toi phan tu dau tien cua s
    dao:
    dec si
    mov bl,[si]         ;
    mov [di],bl         ;gan s[di]=x[si]
    inc di
    cmp si,offset (x+2) ;si tro den phan tu dau tien cua x?
    jnz dao             ;neu chua tiep tuc dao 
    
    ;in ra tb1
    mov ah,9
    lea dx,tb1
    int 21h
    ;in ra xau s
    mov ah,9
    lea dx,s
    int 21h                      
    
    ;nhan phim bat ki de ket thuc:
    mov ah,7
    int 21h
    
    ;ket thuc chuong trinh:
    mov ah,4ch
    int 21h
end