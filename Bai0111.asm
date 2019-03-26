;Nhap 2 so nhi phan 16 bit A,B
;In ra ket qua o dang nhi phan A+B, A-B, A and B, A or B

.model small
.stack 100h
.data
    tbA db "Nhap 2 so nhi phan 16 bit A,B:",10,13,"A:$"
    tbB db 10,13,"B:$"
    x db 17,0,17 dup('$')
    y db 17,0,17 dup('$')
    s1 db 16 dup('0'),'$'
    s2 db 16 dup('0'),'$'
    s3 db 16 dup('0'),'$'
    s4 db 16 dup('0'),'$'
    tb1 db 10,13,"A+B=$"
    tb2 db 10,13,"A-B=$"
    tb3 db 10,13,"A and B=$"
    tb4 db 10,13,"A or  B=$"
.code
    ;khoi tao ds va es:
    mov ax,@data
    mov ds,ax
    mov es,ax
    
    ;in ra tbA:
    mov ah,9
    lea dx,tbA
    int 21h    
    
    ;nhap A luu vao chuoi x:
    mov ah,10
    lea dx,x
    int 21h 
    
    ;in ra tbB:
    mov ah,9
    lea dx,tbB
    int 21h  
    
    ;nhap B luu vao chuoi y:
    mov ah,10
    lea dx,y
    int 21h   
    
    
    ;thuc hien A+B luu ket qua vao s1
    ;truoc tien sao chep chuoi y vao s1 
    lea si,y+2      ;si tro den dau chuoi y
    lea di,s1       ;di tro den dau chuoi s1
    mov cx,16       ;lap 16 lan
    saochep1:
    mov bl,[si]     ;
    mov [di],bl     ;gan s1[di]=y[si]
    inc si
    inc di
    loop saochep1
    ;sau do lay x + s1
    lea si,x+17     ;si tro den cuoi chuoi x
    lea di,s1+15    ;di tro den cuoi chuoi s1
    mov cx,16       ;lap 16 lan
    mov bl,0        ;bl bien nho
    lap1:
    mov al,bl       ;khoi tao al=bl
    add al,[si]     ;
    sub al,48       ;
    add al,[di]     ;
    sub al,48       ;al=bl+x[si]-48+s1[di]-48
                    ;x[si]-48 de chuyen ki tu sang so
                    ;s1[di]-48 de chuyen ki tu sang so
    
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
    lea si,y+2      ;si tro den dau chuoi y
    lea di,s2       ;di tro den dau chuoi s2
    mov cx,16       ;lap 16 lan
    saochep2:
    mov bl,[si]     ;
    mov [di],bl     ;gan s2[di]=y[si]
    inc si
    inc di
    loop saochep2
    ;sau do lay x - s2
    lea si,x+17     ;si tro den cuoi chuoi x
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
    lea si,y+2      ;si tro den dau chuoi y
    lea di,s3       ;di tro den dau chuoi s3
    mov cx,16       ;lap 16 lan
    saochep3:
    mov bl,[si]     ;
    mov [di],bl     ;gan s3[di]=y[si]
    inc si
    inc di
    loop saochep3
    ;sau do lay x and s3
    lea si,x+2      ;si tro den dau chuoi x
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
    lea si,y+2      ;si tro den dau chuoi y
    lea di,s4       ;di tro den dau chuoi s4
    mov cx,16       ;lap 16 lan
    saochep4:
    mov bl,[si]     ;
    mov [di],bl     ;gan s4[di]=y[si]
    inc si
    inc di
    loop saochep4
    ;sau do lay x or s4
    lea si,x+2      ;si tro den dau chuoi x
    lea di,s4       ;di tro den dau chuoi s4
    mov cx,16       ;lap 16 lan
    lap4:
    cmp [si],'1'    ;
    jz gan4         ;
    cmp [di],'1'    ;
    jz gan4         ;
    mov [di],'0'    ;
    jmp thoat4      ;
    gan4:           ;
    mov [di],'1'    ;
    thoat4:
    inc si          ;tang si
    inc di          ;tang di
    loop lap4       ;cx>0 thi lap tiep
    
    ;in ra s1
    mov ah,9
    lea dx,tb1
    int 21h
    lea dx,s1
    int 21h
    ;in ra s2
    lea dx,tb2
    int 21h
    lea dx,s2
    int 21h
    ;in ra s3
    lea dx,tb3
    int 21h
    lea dx,s3
    int 21h
    ;in ra s4
    lea dx,tb4
    int 21h
    lea dx,s4
    int 21h
    
    ;nhap phim bat ki de ket thuc:
    mov ah,7
    int 21h
    ;ket thuc chuong trinh:
    mov ah,4ch
    int 21h 
end