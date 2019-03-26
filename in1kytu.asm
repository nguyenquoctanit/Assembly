.model small
.stack
.data
    TBao1 db "Hay nhap mot ky tu: $"
    TBao2 db 0DH,0AH,"Ky tu da nhap: $"
.code
    
;initialize
    Mov ax,@data
    Mov ds,ax
;print tb1
    Lea dx, TBao1
    Mov ah, 9
    int 21h
;scan
    Mov ah, 1
    Int 21h
    Mov bl, al
;print tb2
    lea dx, TBao2
    mov ah, 9
    int 21h
;print
    Mov ah, 2
    Mov dl, bl
    Int 21h
;return dos
    Mov ah, 4Ch
    Int 21h
end