DOIHETP MACRO TGHI,TAM,XAU
    LOCAL SOTHANHXAU
    LOCAL DAOXAU
    
    ;PUSH AX
    ;PUSH DX
    
    LEA SI,TAM
    MOV AX,TGHI
    MOV DX,0
    SOTHANHXAU:
        MOV BX,10
        DIV BX
        MOV [SI],DX
        ADD [SI],48
        INC SI
        MOV DX,0 
        CMP AX,0
    JNZ SOTHANHXAU
    
    LEA DI,XAU
    DAOXAU:
        DEC SI
        MOV BL,[SI]
        MOV [DI],BL
        INC DI
        CMP SI,OFFSET TAM
    JNZ DAOXAU
    
    MOV AH,09H
    LEA DX,XAU
    INT 21H
ENDM

INGACH MACRO 
    MOV AH,02H
    MOV DL,2FH
    INT 21H
ENDM

.MODEL SMALL
.STACK 100H
.DATA
    XD DB 8 DUP('$')
    TD DB 8 DUP('$')
    XM DB 8 DUP('$')
    TM DB 8 DUP('$')
    XY DB 8 DUP('$')
    TY DB 8 DUP('$')
    SO DB ?

.CODE

    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,2AH
    INT 21H 
    
    MOV SO,DH 
    
    MOV BL,DL
    MOV BH,0
    DOIHETP BX,TD,XD
    
    INGACH
     
    ;MOV SO,DH
    MOV AL,SO
    MOV AH,0
    DOIHETP AX,TM,XM
    
    INGACH
    DOIHETP CX,TY,XY 
    
    MOV AH,4CH
    INT 21H
END