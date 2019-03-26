data segment
    str_in db 'Nhap chuoi ki tu: $' 
    str_in_len  db 'Do dai chuoi la: $'
    
ends 

;define var
str db 200 dup(?)  
key db ' '
adr db ?  
count db ?
tmp db 10 
  
length  db ? 
str_demo db 'Hello$'

address db ? 


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
    
    ;init
    
    lea di, str
    ;nhap chuoi
    begin_loop:
        mov ah, 01h
        int 21h
        mov key, al  
        
        cmp key, 13
        je  end_loop 
        
        ;fecth adr 
        
        stosb
                
        jmp begin_loop                   
    end_loop:
    mov al, '$'
    stosb 
    ;out string
    mov ah, 02h
    mov dl, 13
    int 21h
    
    mov dl, 10
    int 21h
    
    mov ah, 09h
    lea dx, str
    int 21h  
    
    ;xuong hang
    mov ah, 02h
    mov dl, 13
    int 21h
    
    mov dl, 10
    int 21h
    
    ;dem so ki tu 
    lea si, str
    mov length, 0 
    count_loop: 
        
        cmp [si], '$'
        je end_count_loop
        inc si
        inc length 
        jmp count_loop
    end_count_loop:
    
    ;in ra doi dai 
    
    mov count, 0
    
    mov ah, 09h
    lea dx, str_in_len
    int 21h
    
    ;int to str 
    mov ax, 0
    mov al, length
    start_parse_loop:
        
        
             
        div tmp
        
        inc count
        
        push ax
        
        cmp al, 0
        
        je end_parse_loop 
        
        mov ah, 0 
        
        jmp start_parse_loop
        
        
    end_parse_loop:
    
    ;in ra do dai 
    
    start_printf_loop:
       cmp count, 0
       je end_printf_loop:
       
       pop ax
       
       mov dl, '0'
       add dl, ah
   
       mov ah, 02h
       int 21h
       
       dec count 
       
       jmp start_printf_loop
       
    end_printf_loop:
       
    
    
    
     
        

    ;dung man hinh
    mov ah, 01h
    int 21h
ends
end start