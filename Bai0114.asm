;Nhap 2 so A,B o dang thap phan
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
    tbA db "Nhap 2 so thap phan A,B",10,13,"Nhap A:$"
    tbB db 10,13,"Nhap B:$"
    binA db 10,13,"A=$"
    binB db 10,13,"B=$"
    tb1 db 10,13,"A+B=$"
    tb2 db 10,13,"A-B=$"
    tb3 db 10,13,"A and B=$"
    tb4 db 10,13,"A or  B=$"
    Adec db 6,0,6 dup ("$")
    Bdec db 6,0,6 dup ("$")
    A dw ?
    B dw ?
    Abin db 16 dup ("0"),"$"
    Bbin db 16 dup ("0"),"$"
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
    ;nhap A luu vao chuoi Adec:
    mov ah,10
    lea dx,Adec
    int 21h 
    
    ;in ra tbB:
    prin tbB  
    ;nhap B luu vao chuoi Bdec:
    mov ah,10
    lea dx,Bdec
    int 21h   
    
    ;chuyen Adec thanh so,luu vao A
    lea di,Adec+2   ;di tro den phan tu dau tien cua Adec
    mov ax,0        ;khoi tao so bi nhan ax=0 
    c_soA:                          
    mov bx,10       ;so nhan bx=10
    mul bx          ;nhan ax*bx ket qua luu vao dxax
                    ;(o day chuyen sang nhi phan 16bit
                    ;nen chi can lay ax)
    mov cl,[di]     ;luu ki tu Adec[di] vao cl
    sub cl,48       ;chuyen ki tu cl sang so bang cach tru 48
    mov ch,0        ;gan cx=cl bang cach cho ch=0
    add ax,cx
    inc di
    cmp [di],13     ;ket thuc chuoi Adec chua
    jnz c_soA       ;neu chua thi lap tiep
    mov A,ax
    
    ;chuyen Bdec thanh so,luu vao B
    lea di,Bdec+2   ;di tro den phan tu dau tien cua Bdec
    mov ax,0        ;khoi tao so bi nhan ax=0 
    c_soB:                          
    mov bx,10       ;so nhan bx=10
    mul bx          ;nhan ax*bx ket qua luu vao dxax
                    ;(o day chuyen sang nhi phan 16bit
                    ;nen chi can lay ax)
    mov cl,[di]     ;luu ki tu Bdec[di] vao cl
    sub cl,48       ;chuyen ki tu cl sang so bang cach tru 48
    mov ch,0        ;gan cx=cl bang cach cho ch=0
    add ax,cx
    inc di
    cmp [di],13     ;ket thuc chuoi Bdec chua
    jnz c_soB       ;neu chua thi lap tiep
    mov B,ax
            
    ;chuyen A sang dang nhi phan,luu vao Abin
    lea di,Abin+15  ;di tro den phan tu cuoi cua Abin
    mov ax,A        ;khoi tao ax=A
    mov bx,2        ;gan so chia bx=2 
    convertA:
    mov dx,0        ;gan dxax=ax bang cach cho dx=0
    div bx          ;chia dxax/bx thuong luu vao ax
    mov [di],dl     ;luu so du dx vao Abin[di]
                    ;so du luon <2 nen ta co dx=dl
    add [di],48     ;chuyen so sang ki tu bang cach +48
    dec di
    cmp ax,0        ;so sanh ax=0 chua
    jnz convertA    ;neu chua thi lap tiep
    
    ;chuyen B sang dang nhi phan,luu vao Bbin
    lea di,Bbin+15  ;di tro den phan tu cuoi cua Bbin
    mov ax,B        ;khoi tao ax=B
    mov bx,2        ;gan so chia bx=2 
    convertB:
    mov dx,0        ;gan dxax=ax bang cach cho dx=0
    div bx          ;chia dxax/bx thuong luu vao ax
    mov [di],dl     ;luu so du dx vao Abin[di]
                    ;so du luon <2 nen ta co dx=dl
    add [di],48     ;chuyen so sang ki tu bang cach +48
    dec di
    cmp ax,0        ;so sanh ax=0 chua
    jnz convertB    ;neu chua thi lap tiep
    
    ;thuc hien A+B luu ket qua vao s1
    ;truoc tien sao chep chuoi Bbin vao s1 
    lea si,Bbin     ;si tro den dau chuoi Bbin
    lea di,s1       ;di tro den dau chuoi s1
    mov cx,16       ;lap 16 lan
    saochep1:
    mov bl,[si]     ;
    mov [di],bl     ;gan s1[di]=Bbin[si]
    inc si
    inc di
    loop saochep1
    ;sau do lay Abin + s1
    lea si,Abin+15  ;si tro den cuoi chuoi Abin
    lea di,s1+15    ;di tro den cuoi chuoi s1
    mov cx,16       ;lap 16 lan
    mov bl,0        ;bl bien nho
    lap1:
    mov al,bl       ;
    add al,[si]     ;
    sub al,48       ;
    add al,[di]     ;
    sub al,48       ;al=bl+Abin[si]-48+s1[di]-48
    
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
    ;truoc tien sao chep chuoi Bbin vao s2 
    lea si,Bbin     ;si tro den dau chuoi Bbin
    lea di,s2       ;di tro den dau chuoi s2
    mov cx,16       ;lap 16 lan
    saochep2:
    mov bl,[si]     ;
    mov [di],bl     ;gan s2[di]=Bbin[si]
    inc si
    inc di
    loop saochep2
    ;sau do lay Abin - s2
    lea si,Abin+15  ;si tro den cuoi chuoi Abin
    lea di,s2+15    ;di tro den cuoi chuoi s2
    mov cx,16       ;lap 16 lan
    mov bl,0        ;bl bien nho
    lap2:
    mov al,[si]     ;
    add al,48       ;
    sub al,[di]     ;
    sub al,bl       ;al=Abin[si]-s2[di]+48-bl
    
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
    ;truoc tien sao chep chuoi Bbin vao s3 
    lea si,Bbin     ;si tro den dau chuoi Bbin
    lea di,s3       ;di tro den dau chuoi s3
    mov cx,16       ;lap 16 lan
    saochep3:
    mov bl,[si]     ;
    mov [di],bl     ;gan s3[di]=Bbin[si]
    inc si
    inc di
    loop saochep3
    ;sau do lay Abin and s3
    lea si,Abin     ;si tro den dau chuoi Abin
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
    ;truoc tien sao chep chuoi Bbin vao s4 
    lea si,Bbin     ;si tro den dau chuoi Bbin
    lea di,s4       ;di tro den dau chuoi s4
    mov cx,16       ;lap 16 lan
    saochep4:
    mov bl,[si]     ;
    mov [di],bl     ;gan s4[di]=Bbin[si]
    inc si
    inc di
    loop saochep4
    ;sau do lay Abin or s4
    lea si,Abin     ;si tro den dau chuoi Abin
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
    prin Abin
    prin binB
    prin Bbin
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