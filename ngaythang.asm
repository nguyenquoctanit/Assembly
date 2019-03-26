DSEG SEGMENT  
    
    MSG1 DB 'HOM NAY LA : $'
    thu     db     'SunMonTueWedThuFriSat $'
    St_date db     20, 0, 20 dup(0)
    ngay DB ?
    thang DB ?
    nam DW ?     
DSEG ENDS

SSEG SEGMENT
    DB 100 DUP (?)
SSEG ENDS    

CSEG SEGMENT 
    
    ASSUME  CS:CSEG , DS:DSEG
    START: MOV AX,DSEG
    MOV DS,AX
    
    LEA SI,St_date
    MOV AH,09H
    LEA DX,MSG1
    INT 21H
    
    MOV AH,2AH
    INT 21H
;Vào:AH=2Ah
;Ra:AL=thu trong tun(0=C.nhat,6=T.bay)
;DL=ngày(1-31)
;DH=thang(1-12)
;CX=nam(1980-2099) 
    
    XOR AH,AH
    MOV ngay,DL
    MOV thang,DH
    MOV nam,CX
     
    
    MOV BL,3
    MUL BL
    
     
    MOV SI,AX    
    MOV CX,3
    
    _THU:
     MOV AH, 02H
     mov DL,    thu[SI]
    int 21h
    inc SI
    loop _THU
    
    MOV AH,02H
    MOV DL,0
    INT 21H 
    
    _NGAY:
    MOV AL,ngay
    XOR AH,AH
    MOV BL,10
    DIV BL
    
    ADD AH,30H
    ADD AL,30H
    MOV BH,AH
    
    MOV AH,02H
    MOV DL,AL
    INT 21H
    MOV AH,02H
    MOV DL,BH
    INT 21H
    
    MOV AH,02H
    MOV DL,'-'
    INT 21H 
    
    _THANG:
    MOV AL,thang
    XOR AH,AH
    MOV BL,10
    DIV BL
    
    ADD AH,30H
    ADD AL,30H
    MOV BH,AH
    
    MOV AH,02H
    MOV DL,AL
    INT 21H
    MOV AH,02H
    MOV DL,BH
    INT 21H 
    
    
    
    MOV AH,02H
    MOV DL,'-'
    INT 21H 
    
    
    MOV AX,nam
    MOV BX,10
    
    XOR CX,CX
    MOV CX,4
           
    _NAM: 
    
    XOR DX,DX
    DIV BX
    PUSH DX
    LOOP _NAM 
    
    XOR CX,CX
    MOV CX,4   
    
    _XUATNAM:
    POP DX
    ADD DL,30H
    MOV AH,02H
    INT 21H
    
    LOOP _XUATNAM       
    
    EXIT:
    MOV AH,08H
    INT 21H
    
CSEG ENDS
END START
