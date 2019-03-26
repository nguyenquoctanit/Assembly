DSEG SEGMENT
Time_Buf DB '00:00:00$'
DSEG ENDS

CSEG SEGMENT
 ASSUME: CS:CSEG,DS:DSEG

START:MOV AX, DSEG
MOV DS, AX


MOV AH, 2Ch 
INT 21h 

;AH = 2Ch
;Ra: CH = gio 
;CL = phut 
;DH = giay
;DL = % giay


MOV AL, CH 
MOV AH, 0
MOV DL, 10 
DIV DL 


ADD AL, 30h 
ADD AH, 30h 
MOV Time_Buf, AL 
MOV Time_Buf+1, AH


MOV AL, CL 
MOV AH, 0
MOV DL, 10 
DIV DL 

ADD AL, 30h 
ADD AH, 30h
MOV Time_Buf+3, AL 
MOV Time_Buf+4, AH


MOV AL, DH 
MOV AH, 0
MOV DL, 10 


DIV DL 

OR AX, 3030h 
MOV Time_Buf+6, AL
MOV Time_Buf+7, AH 

mov ah,02h  ;Di chuyen
mov dx,1545h;con tro toi
int 10h     ;dong 12 (0c) cot 21 (15)
        

MOV AH, 9 
LEA DX, Time_Buf 

INT 21h 
mov ah,08h 
int 21h
MOV AH, 4Ch 
INT 21h

CSEG ENDS
END START
