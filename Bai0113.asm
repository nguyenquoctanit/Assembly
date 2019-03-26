;Nhap 2 so A,B o dang hex
;Tinh va in ra ket qua o dang nhi phan 16 bit
;cac phep A+B, A-B, A and B, A or B

prin macro s    ;macro prin in ra chuoi s
    mov ah,9
    lea dx,s
    int 21h
endm

.model small
.stack 100h
.data
    tbA db "Nhap 2 so hex A,B",10,13,"Nhap A:$"
    tbB db 10,13,"Nhap B:$"
    binA db 10,13,"A=$"
    binB db 10,13,"B=$"
    tb1 db 10,13,"A+B=$"
    tb2 db 10,13,"A-B=$"
    tb3 db 10,13,"A and B=$"
    tb4 db 10,13,"A or  B=$"
    xhex db 5,0,5 dup ("$")
    yhex db 5,0,5 dup ("$")
    x db 16 dup ("0"),"$"
    y db 16 dup ("0"),"$"
    s1 db 16 dup ("0"),"$"
    s2 db 16 dup ("0"),"$"
    s3 db 16 dup ("0"),"$"
    s4 db 16 dup ("0"),"$" 
.code
    ;khoi tao ds va es:
    mov ax,@data
    mov ds,ax
    mov es,ax
    
    ;in ra tbA:
    prin tbA    
    ;nhap A luu vao chuoi xhex:
    mov ah,10
    lea dx,xhex
    int 21h 
    
    ;in ra tbB:
    prin tbB  
    ;nhap B luu vao chuoi yhex:
    mov ah,10
    lea dx,yhex
    int 21h   
    
    ;chuyen A sang dang nhi phan,luu vao x
    lea si,xhex+2   ;si tro den phan tu dau cua xhex
    nhay1:
    inc si
    cmp [si],13
    jnz nhay1
    mov [si],"$"
    dec si          ;si tro den phan tu cuoi cung cua xhex
    lea di,x+15     ;di tro den phan tu cuoi cua x
    mov bl,2        ;gan so chia bl=2 
    convertA:
    mov al,[si]     ;al = ki tu xhex[si]
    sub al,48       ;chuyen ki tu sang so
    cmp al,10
    jb Akem10       ;neu al<10 thi bo qua
    sub al,7        ;neu xhex[si]='A'->'F' thi phai giam al di 7
    cmp al,10
    jb Akem10       ;neu al<10 thi bo qua
    sub al,32       ;neu xhex[si]='a'->'f' thi phai giam al di (7+32)
    Akem10:
    mov cx,4        ;lap 4 lan
    convert1:
    mov ah,0        ;ah=0 thi so bi chia ax=al
    div bl          ;chia ax/bl
    mov [di],ah     ;x[di]=so du ah
    add [di],48     ;chuyen so sang ki tu
    dec di          
    loop convert1   ;khi cx=0 thi dung
    dec si
    cmp si,offset (xhex+2)  ;so sanh si voi dia chi xhex
    jnb convertA            ;neu con tro si>=offset xhex thi lap tiep
    
    ;chuyen B sang dang nhi phan,luu vao y
    lea si,yhex+2   ;si tro den phan tu dau cua xhex
    nhay2:
    inc si
    cmp [si],13
    jnz nhay2
    mov [si],"$"
    dec si          ;si tro den phan tu cuoi cung cua yhex
    lea di,y+15     ;di tro den phan tu cuoi cua y
    mov bl,2        ;gan so chia bl=2 
    convertB:
    mov al,[si]     ;al = ki tu xhex[si]
    sub al,48       ;chuyen ki tu sang so
    cmp al,10
    jb Bkem10       ;neu al<10 thi bo qua
    sub al,7        ;neu yhex[si]='A'->'F' thi phai giam al di 7
    cmp al,10
    jb Bkem10       ;neu al<10 thi bo qua
    sub al,32       ;neu yhex[si]='a'->'f' thi phai giam al di (7+32)
    Bkem10:
    mov cx,4        ;lap 4 lan
    convert2:
    mov ah,0        ;ah=0 thi so bi chia ax=al
    div bl          ;chia ax/bl
    mov [di],ah     ;x[di]=so du ah
    add [di],48     ;chuyen so sang ki tu
    dec di          
    loop convert2   ;khi cx=0 thi dung
    dec si
    cmp si,offset (yhex+2)  ;so sanh si voi dia chi yhex
    jnb convertB            ;neu con tro si>=offset yhex thi lap tiep
    
    ;thuc hien A+B luu ket qua vao s1
    ;truoc tien sao chep chuoi y vao s1 
    lea si,y        ;si tro den dau chuoi y
    lea di,s1       ;di tro den dau chuoi s1
    mov cx,16       ;lap 16 lan
    saochep1:
    mov bl,[si]     ;
    mov [di],bl     ;gan s1[di]=y[si]
    inc si
    inc di
    loop saochep1
    ;sau do lay x + s1
    lea si,x+15     ;si tro den cuoi chuoi x
    lea di,s1+15    ;di tro den cuoi chuoi s1
    mov cx,16       ;lap 16 lan
    mov bl,0        ;bl bien nho
    lap1:
    mov al,bl       ;
    add al,[si]     ;
    sub al,48       ;
    add al,[di]     ;
    sub al,48       ;al=bl+x[si]-48+s1[di]-48
    
    cmp al,3        
    jz bang3        
    cmp al,2
    jz bang2
    cmp al,1
    jz bang1
    mov [di],'0'    ;mac dinh neu al=0 thi gan s1[di]=0 
    mov bl,0        ;va so du bl=0
    jmp thoat1
    bang3:          ;neu al=3 
    mov [di],'1'    ;gan s1[di]=1
    mov bl,1        ;va so du bl=1
    jmp thoat1
    bang2:          ;neu al=2
    mov [di],'0'    ;gan s1[di]=0
    mov bl,1        ;va so du bl=1
    jmp thoat1
    bang1:          ;neu al=1
    mov [di],'1'    ;gan s1[di]=1
    mov bl,0        ;va so du bl=0
    thoat1:         
    dec si
    dec di
    loop lap1
    
    ;thuc hien A-B luu ket qua vao s2
    ;truoc tien sao chep chuoi y vao s1 
    lea si,y        ;si tro den dau chuoi y
    lea di,s2       ;di tro den dau chuoi s2
    mov cx,16       ;lap 16 lan
    saochep2:
    mov bl,[si]     ;
    mov [di],bl     ;gan s2[di]=y[si]
    inc si
    inc di
    loop saochep2
    ;sau do lay x - s2
    lea si,x+15     ;si tro den cuoi chuoi x
    lea di,s2+15    ;di tro den cuoi chuoi s2
    mov cx,16       ;lap 16 lan
    mov bl,0        ;bl bien nho
    lap2:
    mov al,[si]     ;
    add al,48       ;
    sub al,[di]     ;
    sub al,bl       ;al=x[si]-s2[di]+48-bl
    
    cmp al,49        
    jz bang49        
    cmp al,48
    jz bang48
    cmp al,47
    jz bang47
    mov [di],'0'    ;mac dinh neu al=46 thi gan s2[di]=0 
    mov bl,1        ;va so du bl=1
    jmp thoat2
    bang49:         ;neu al=49 
    mov [di],'1'    ;gan s2[di]=1
    mov bl,0        ;va so du bl=0
    jmp thoat2
    bang48:         ;neu al=48
    mov [di],'0'    ;gan s2[di]=0
    mov bl,0        ;va so du bl=0
    jmp thoat2
    bang47:         ;neu al=47
    mov [di],'1'    ;gan s2[di]=1
    mov bl,1        ;va so du bl=1
    thoat2:         
    dec si
    dec di
    loop lap2
    
    ;thuc hien A and B luu ket qua vao s3:
    ;truoc tien sao chep chuoi y vao s3 
    lea si,y        ;si tro den dau chuoi y
    lea di,s3       ;di tro den dau chuoi s3
    mov cx,16       ;lap 16 lan
    saochep3:
    mov bl,[si]     ;
    mov [di],bl     ;gan s3[di]=y[si]
    inc si
    inc di
    loop saochep3
    ;sau do lay x and s3
    lea si,x        ;si tro den dau chuoi x
    lea di,s3       ;di tro den dau chuoi s3
    mov cx,16       ;lap 16 lan
    lap3:
    cmp [si],'0'
    jz gan3
    cmp [di],'0'
    jz gan3
    mov [di],'1'
    jmp thoat3
    gan3:
    mov [di],'0'
    thoat3:
    inc si
    inc di
    loop lap3
    
    ;thuc hien A or B luu ket qua vao s4:
    ;truoc tien sao chep chuoi y vao s4 
    lea si,y        ;si tro den dau chuoi y
    lea di,s4       ;di tro den dau chuoi s4
    mov cx,16       ;lap 16 lan
    saochep4:
    mov bl,[si]     ;
    mov [di],bl     ;gan s4[di]=y[si]
    inc si
    inc di
    loop saochep4
    ;sau do lay x or s4
    lea si,x        ;si tro den dau chuoi x
    lea di,s4       ;di tro den dau chuoi s4
    mov cx,16       ;lap 16 lan
    lap4:
    cmp [si],'1'
    jz gan4
    cmp [di],'1'
    jz gan4
    mov [di],'0'
    jmp thoat4
    gan4:
    mov [di],'1'
    thoat4:
    inc si
    inc di
    loop lap4
    
    ;in ra A va B o dang nhi phan
    prin binA
    prin x
    prin binB
    prin y
    ;in ra s1
    prin tb1
    prin s1
    ;in ra s2
    prin tb2
    prin s2
    ;in ra s3
    prin tb3
    prin s3
    ;in ra s4
    prin tb4
    prin s4
    
    ;ket thuc chuong trinh:
    mov ah,4ch
    int 21h
end