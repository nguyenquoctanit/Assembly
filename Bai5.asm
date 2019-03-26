data segment   
    str_in  db 'Nhap lenh: $'
    str_s   db 13, 10, 'Good Morning!$'
    str_t   db 13, 10, 'Good Afternoon!$'
    str_c   db 13, 10, 'Good Evening!$' 
    str_ukn db 13, 10, 'Unknown!$'

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
    
    ;cho nhap lenh
    mov ah, 01h
    int 21h
    
    mov key, al
    
    switch:
        cmp key, 's'
        je morning
        cmp key, 'S'
        je morning 
        
        cmp key, 't'
        je afternoon
        cmp key, 'T'
        je afternoon  
        
        cmp key, 'c'
        je evening
        cmp key, 'C'
        je evening
        
        jmp unkn
        
        
    
    
    
    
    ;cac loi chao
    
        morning: 
            mov ah, 09h
            lea dx, str_s
            int 21h 
            
            jmp end_switch
        
        afternoon:
            mov ah, 09h
            lea dx, str_t
            int 21h
            
            jmp end_switch
            
        evening:
            mov ah, 09h
            lea dx, str_c
            int 21h
            
            jmp end_switch 
        
        unkn:
            mov ah, 09h
            lea dx, str_ukn
            int 21h
            
            jmp end_switch    
    
    end_switch:
                       
    ;dung man hinh
    mov ah, 01h
    int 21h 
;end code
ends
end start