;Co 2 mang chua cac bit (moi bit/mot byte),
;viet doan lenh tru 2 mang, luu ket qua vao mang ketqua
.model small                                           
.stack 100h
.data
    mA db 0,1,1,0,0,0,1,1,1,0,1,1,0,0,0,1
    mB db 1,0,0,1,0,0,0,1,0,0,1,1,0,1,1,1
    mC db 17 dup(?)
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov cx, 16      
    lea si, mA      ; si -> mA
    lea di, mB      ; di -> mB
    xor ax, ax      
    xor bx, bx
    
nhap:
    ;-- dua mA vao thanh ax
    shl ax, 1       ; dinh ax qua trai 1 bit
    or al, [si]     ; luu [si] vao bit cuoi cung cua ax 
    inc si          ; tang si
    ;-- dua mB vao thanh bx
    shl bx, 1    
    or bl, [di]
    inc di
    loop nhap
    
    ;-- lay ax - bx, 
    ;-- lay ket qua chuyen ve nhi phan luu vao mC

    sub ax, bx      
    lea si, mC
    adc [si], 0     ; add with carry
    inc si
    mov cx, 16
chuyen:
    rol ax, 1       ; roll left 1 bit
    mov bx, ax
    and bx, 1
    mov [si], bx
    inc si
    loop chuyen
    
    mov ah, 4ch
    int 21h
main endp
end main