data segment
    str_in db 'Nhap mot ki tu: $'
ends 

;define var

key db ' '

code segment
start:   
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
;start code 

    mov ah, 09h
    lea dx, str_in
    int 21h
    
    ;nhap ki tu
    
    mov ah, 01h
    int 21h
    
    mov key, al  
    
    ;xuong dong
    mov ah, 02h
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    
    ;bat dau in
     
    mov ah, 02h
    begin_loop: 
        
        cmp key, 'z'        
        ja end_loop
        
        mov dl, key
        int 21h
        
        mov dl, ' '
        int 21h
        
        inc key
        
        
        jmp begin_loop
        
    end_loop:
    ;dung man hinh
    mov ah, 01h
    int 21h
ends
end start