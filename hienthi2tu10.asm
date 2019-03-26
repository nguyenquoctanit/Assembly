; Doc cac ky tu la chu so va luu vao mang, hien thi nhi pha
; tuong ung voi he so 10
.model small
.stack 100h
.data
    tbn db 'Nhap so (toi da 99999): $'
    tbx db 10, 13,'Ket qua: $'
    mang db 10 dup(?)
.code
main proc
    mov ax, @data
    mov ds, ax
    ;-- in thong bao nhap
    lea dx, tbn
    mov ah, 09h
    int 21h
      
    xor cx, cx      ; xoa thanh cx
    lea di, mang    ; tro di toi mang
    mov ah, 01h     ; ham nhap ky tu
nhap:    
    int 21h
    cmp al, 13      ; so sanh voi enter
    je thoat
    sub al, '0'     ; chuyen tu ascii -> so
    mov [di], al    ; di chuyen tung ky tu vao mang 
    inc di
    inc cx          ; cx <- so chu so
    jmp nhap
thoat:
    lea si, mang    ; tro si -> mang
    xor ax, ax      ; xoa thanh ax
    xor bx, bx      
    mov di, 10      ; di <- so nhan = 10
nhan:
    mul di          ; nhan 16 bit
    mov bl, [si]    
    add ax, bx      ; cong pt tiep theo cua mang vao ax                 
    inc si          ; ax toi da 65535
    loop nhan       ; neu lon hon, ket qua se khong dung
    
    push ax         ; day ax vao stack
    push dx         ; day dx vao stack
    ;-- in thong bao xuat
    lea dx, tbx
    mov ah, 09h
    int 21h
    
    pop bx           ; lay ket qua o dx -> bx
    cmp bx, 0       ; so sanh neu dx != 0
    je in16b        ; tuc phep nhan cho kq > 16 bit, 
    mov cx, 4       ; in them 4 bit cuoi cua dx 
    rol bl, 4       ; quay bl 4 de bat dau in 4 bit thap
    mov ah, 02h
    ;-- in 4 bit o dx
indx:
    rol bl, 1       ; quay trai 10100000 -> 01000001
    mov dl, bl
    and dl, 1       ; and voi 1 -> 00000001
    add dl, '0'     ; chuyen thanh ascii
    int 21h
    loop indx 
    ;-- in 16 bit o ax                   
in16b:
    mov cx, 16     
    pop bx          ; lay ket qua thuong ax trong stack -> bx
    mov ah, 02h
inax:
    rol bx, 1       ; quay trai bx 1 bit
    mov dl, bl
    and dl, 1       ; and voi 1
    add dl, '0'
    int 21h  
    loop inax                    
    mov ah, 4ch
    int 21h
    main endp
end main