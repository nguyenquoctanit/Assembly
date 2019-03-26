
TITLE BAI9

; SINH VIEN: THAI QUANG TIEN    MSSV: 102150136
; SINH VIEN:         
; LOP      : 15T2

.model SMALL

.stack 100h

.data
msg1 DB "N1: $"
msg2 DB 0Dh,0Ah,"N2: $"
msg3 DB 0Dh,0Ah,"N1+N2= $"
num1 DB 10,?,11 DUP("$")
num12 DW ?
num2 DB 10,?,11 DUP("$")
num22 DW ?
num3 DB 11 DUP("$")
num32 DW ?
num_char DB 0

.code
main PROC
    mov AX,@data
    mov DS,AX
    
    mov AH,09h            ;Display msg1
    lea DX,msg1
    int 21h
    
    mov AH,0Ah            ;Input string1
    lea DX,num1
    int 21h
    
    mov AH,09h            ;Display msg2
    lea DX,msg2
    int 21h
    
    mov AH,0Ah            ;Input string2
    lea DX,num2
    int 21h
                      
                      
    ;String to number1     
    mov CX,0              ;Set loop count
    mov CL,num1+1
    mov SI,OFFSET num1+2  ;SI as a pointer
    loop1:
    mov AH,0              ;num12 x 10
    mov AL,10
    mul num12
    mov num12,AX
    mov BX,0              ;Assign each character to BX
    mov BL,BYTE PTR [SI]  
    sub BL,48             ;Character to number
    add num12, BX         ;num12 + number
    inc SI
    loop loop1        
    
    ;String to number2    ;Same as loop1
    mov CX,0   
    mov CL,num2+1
    mov SI,OFFSET num2+2
    loop2:
    mov AH,0
    mov AL,10
    mul num22
    mov num22,AX
    mov BX,0    
    mov BL,BYTE PTR [SI]
    sub BL,48
    add num22, BX
    inc SI
    loop loop2
    
    ;Add number1 to number2
    mov BX,num12
    add BX,num22
    mov num32,BX
    
    
    ;Number3 to string      
    mov SI,OFFSET num3      ;SI as a pointer
    mov BX,0                ;Set BL=10 as the divisor
    mov BL,10
    loop3:
    mov DX,0                ;DIV with 16bit-dividend
    mov AX,num32
    div BX
    add DL,48               ;Number to character
    mov BYTE PTR [SI],DL    ;Assign to each element in the array
    inc SI 
    mov num32,AX            ;Re-calculate num32
    inc num_char            ;Character count
    cmp num32,0             ;Conditional jump
    jne loop3
    
    ;display string3
    mov AH,09h        ;Display msg3
    lea DX,msg3
    int 21h
    
    mov AX,0          ;Set SI's value
    mov AL,num_char
    dec AX
    mov SI,AX
    
    mov CX,0          ;Set loop count
    mov CL,num_char
    mov AH,02h        ;INT 02h
    loop4:            ;Loop for displaying characters
    mov DL,num3[SI]   ;Display each character in order
    int 21h
    dec SI
    loop loop4
    
main ENDP
END main
    