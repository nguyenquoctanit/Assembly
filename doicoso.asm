                                              ;#####################################
;LUU Y': XUAT THAP PHAN PHAI XUAT RA SO CO DAU VA KHONG DAU NEN PHAI KHAI BAO MSG11 VA MSG12
                       ;##################################### 

inxau       macro   tbao
            push    ax
            push    dx
            mov     ah, 9
            lea     dx, tbao
            int     21h
            pop     dx
            pop     ax
endm

clrscr      macro
    mov     ah, 0fh
    int     10h
    mov     ah, 00h
    int     10h
    xor     ax, ax
    xor     bx, bx
    xor     cx, cx
    xor     dx, dx
    and     n, 0    
endm  

;@********* STACK SEGMENT ***********@
;#####################################

segstack    segment     stack
            db  100     dup(?)               
segstack    ends  

;@********* DATA SEGMENT ************@
;#####################################

segdata     segment
    
    msg1    db  0ah, 0dh, '  chon co 1 trong cac he chuyen:'
            db  0ah, 0dh, '  1: co so 10 sang co so 2.'
            db  0ah, 0dh, '  2: co so 2 sang co so 8.'
            db  0ah, 0dh, '  3: co so 8 sang co so 16.'
            db  0ah, 0dh, '  4: co so 16 sang co so 10.'
            db  0ah, 0dh, '  chon: $' 
            
    msg2    db  0ah, 0dh, 'Nhap so nguyen (-32768 => 32767 hoac 0 => 65535): $'
    msg3    db  0ah, 0dh, 'Nhap so nhi phan 16 bit: $'
    msg4    db  0ah, 0dh, 'Nhap so bat phan (so co 5 chu so co dang: 1xxxx hoac 0xxxx): $'
    msg5    db  0ah, 0dh, 'Nhap so thap luc phan 16 bit: $'  
    
    msg6    db  0ah, 0dh, 'Xuat ra dang thap phan: $'
    msg7    db  0ah, 0dh, 'Xuat ra dang nhi phan: $'
    msg8    db  0ah, 0dh, 'Xuat ra dang bat phan: $'
    msg9    db  0ah, 0dh, 'Xuat ra dang thap luc phan: $'
    
    msg10   db  0ah, 0dh, 0ah, 0dh, 'ban muon tiep tuc? y/n $'  

;********* ONLY 4 XUAT THAP PHAN ***********
    
    msg11   db  0ah, 0dh, 'co dau   : $'
    msg12   db  0ah, 0dh, 'khong dau: $'   
    
;*******************************************  
  
    n       dw  0
    
segdata     ends
       

;@********* CODE SEGMENT ************@
;##################################### 
       
segcode     segment
    assume  cs:segcode, ss:segstack, ds:segdata
start:    
    mov     ax, segdata
    mov     ds, ax
l1:    
    clrscr 
    
    inxau   msg1
    mov     ah, 1
    int     21h  
    
    cmp     al, 31h      ; chon 1
    je      convert10_2
    
    cmp     al, 32h      ; chon 2
    je      convert2_8 
    
    cmp     al, 33h      ; chon 3
    je      convert8_16 
    
    cmp     al, 34h      ; ko chon 4 
    jne     l1

;convert16_10 
    inxau   msg5
    call    nhap_16
    inxau   msg6
    call    in_thap_phan
    jmp     hoi 
    
convert8_16:
    inxau   msg4
    call    nhap_bat_phan
    inxau   msg9
    call    in_16
    jmp     hoi  
    
convert2_8:
    inxau   msg3
    call    nhap_nhi_phan
    inxau   msg8
    call    in_bat_phan
    jmp     hoi  
      
convert10_2:
    inxau   msg2
    call    nhap_thap_phan
    inxau   msg7
    call    in_nhi_phan 

;**** YES/NO QUESTION ?******
       
hoi:
    inxau   msg10
    mov     ah, 1
    int     21h
    xor     al, 'y'
    jz      l1                
    mov     ah, 4ch
    int     21h
                  
                  
;********* INPUT **********
;   *********  ********** 
                             
                             
;********* NHAP THAP PHAN ********** 
   
nhap_thap_phan      proc
    push    ax
    push    bx
    push    cx
    push    dx
    push    si

    and     n, 0h
    xor     cx, cx      ; ch dem so chu so, cl xac dinh dau
    xor     si, si
    mov     bx, 10
lap_tp_1:
    mov     ah, 1
    int     21h
    cmp     al, 13
    je      kt_dau
    cmp     al, '-'
    je      dau
    cmp     al, '0'
    jl      lap_tp_1
    cmp     al, '9'
    jg      lap_tp_1
    jmp     nhay_tp_1
dau:
    or      cl, 1
    jmp     lap_tp_1
nhay_tp_1:
    and     ax, 0fh
    mov     si, ax
    mov     ax, n
    mul     bx
    add     ax, si
    mov     n, ax
    inc     ch
    cmp     ch,5
    jl      lap_tp_1
kt_dau:
    test    cl, cl
    jz      ketthuc_tp_1
    neg     n
ketthuc_tp_1:
    pop     si
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
nhap_thap_phan      endp     


;********* NHAP NHI PHAN **********


nhap_nhi_phan       proc
    push    ax
    push    cx

    xor     cx, cx      ; dem so bit
    and     n, 0
    mov     ah, 1
lap_np_1:
    int     21h
    cmp     al, 13
    je      ketthuc_np_1
    cmp     al, '0'
    jl      lap_np_1
    cmp     al, '1'
    jg      lap_np_1

    shr     al, 1
    rcl     n, 1
    inc     cx
    test    cx, 0f0h    ; du 16 bit thi dung
    jz      lap_np_1
ketthuc_np_1:
    pop     cx
    pop     ax
    ret                   
nhap_nhi_phan       endp


;********* NHAP BAT PHAN ********** 


nhap_bat_phan       proc
    push    ax
    push    bx
    push    cx

    xor     cx, cx      ;dem so chu so
    xor     bx, bx
    mov     ah, 1
lap_bp_1:
    int     21h
    cmp     al, 13
    je      ketthuc_bp_1
    cmp     al, '0'
    jl      lap_bp_1
    cmp     al, '7'
    jg      lap_bp_1

    and     al, 7
    shl     bx, 3
    or      bl, al
    inc     cx
    cmp     cx, 5
    jl      lap_bp_1
ketthuc_bp_1:
    mov     n, bx
    pop     cx
    pop     bx
    pop     ax
    ret
nhap_bat_phan       endp 


;********* NHAP THAP LUC PHAN **********
                                       
                                       
nhap_16             proc
    push    ax
    push    bx
    push    cx

    xor     cx, cx      ;dem so chu so
    xor     bx, bx
    mov     ah, 1
lap_16_1:
    int     21h
    cmp     al, 13
    je      ketthuc_16_1
    cmp     al, '0'
    jl      lap_16_1
    cmp     al, '9'
    jle     next_16_1
    cmp     al, 'A'
    jl      lap_16_1
    cmp     al, 'F'
    jle     next_16_2
    cmp     al, 'a'
    jl      lap_16_1
    cmp     al, 'f'
    jg      lap_16_1
    sub     al, 32
next_16_2:
    sub     al, 7
next_16_1:
    sub     al, 48
    shl     bx, 4
    or      bl, al
    inc     cx
    cmp     cx, 4
    jl      lap_16_1
ketthuc_16_1:
    mov     n, bx
    pop     cx
    pop     bx
    pop     ax
    ret
nhap_16             endp    
  
  
;********* OUTPUT ***********
;   *********  ***********
    

;********* XUAT THAP PHAN **********
    
in_thap_phan        proc
    push    ax
    push    bx
    push    cx
    push    dx
    push    si

    mov     ax, n
    xor     cx, cx
    mov     bx, 10
    mov     si, 10h         ; si kiem tra so lan goi lap_tp_2 va dau
    inxau   msg11
    cmp     ax, 8000h       ; so am !?
    jb      lap_tp_3
    or      si, 1
    neg     ax
    jmp     lap_tp_3
lap_tp_2:    
    xor     si, si          ; chay lap_tp_2 va thoat
    mov     ax, n
    xor     cx, cx
    inxau   msg12
    jmp     lap_tp_3
lap_tp_3:
    xor     dx, dx
    div     bx
    push    dx
    inc     cx
    test    ax, ax
    jnz     lap_tp_3

    test    si, 1
    jz      lap_tp_4
    mov     ah, 2
    mov     dl, '-'
    int     21h
lap_tp_4:
    pop     dx
    mov     ah, 2
    or      dl, 30h
    int     21h
    loop    lap_tp_4
    test    si, si
    jnz     lap_tp_2

    pop     si
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
in_thap_phan        endp  


;********* XUAT NHI PHAN **********
                         
                         
in_nhi_phan         proc
    push    ax
    push    bx
    push    cx
    push    dx

    mov     bx, n
    mov     cx, 16
    mov     ah, 2
lap_np_2:
    xor     dx, dx
    shl     bx, 1
    rcl     dl, 1
    or      dl, 30h
    int     21h
    loop    lap_np_2

    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
in_nhi_phan     endp
                       
                       

;********* XUAT BAT PHAN **********  


in_bat_phan     proc
    push    ax
    push    bx
    push    cx
    push    dx

    mov     cl, 5h        
    mov     bx, n
    xor     dx, dx
    shl     bx, 1
    rcl     dl, 1
    mov     ah, 2
    or      dl, 30h
    int     21h
lap_bp_2:
    xor     dx, dx
    mov     ch, 3h
lap_bp_3:
    shl     bx, 1
    rcl     dl, 1
    dec     ch
    jnz     lap_bp_3
    or      dl, 30h
    int     21h
    dec     cl
    jnz     lap_bp_2

    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
in_bat_phan     endp
                      
                      
;********* XUAT THAP LUC PHAN ********** 
                            
                            
in_16           proc
    push    ax
    push    bx
    push    cx
    push    dx

    mov     cl, 4
    mov     bx, n
    mov     ah, 2
lap_16_2:
    xor     dx, dx
    mov     ch, 4
lap_16_3:
    shl     bx, 1
    rcl     dl, 1
    dec     ch
    jnz     lap_16_3
    cmp     dl, 10
    jl      nhay_16
    add     dl, 7
nhay_16:
    add     dl, 48
    int     21h
    dec     cl
    jne     lap_16_2

    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
in_16           endp

;***********************************
;*********************************** 
;***********************************  

segcode         ends
    end         start
