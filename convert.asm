PUBLIC  BUFA,convert
EXTRN  INVAL:WORD
.386
.MODEL SMALL
DATA    SEGMENT  USE16
BUFA    DB 15 DUP(0)
DATA    ENDS
STACK1   SEGMENT  USE16 STACK
        DB  1000 DUP(0)
STACK1   ENDS
_TEXT    SEGMENT  USE16  PUBLIC 'CODE'
		ASSUME CS:_TEXT,DS:DATA,SS:STACK1
convert  PROC  NEAR
		PUSH  EAX
		PUSH  EBX
		PUSH  ESI
		PUSH  DS
		MOVZX EAX,INVAL
		MOV   EBX,16            ;ת��16������ʽ��ʾ
		MOV  ESI,offset DATA
		MOV   DS,SI
		LEA   SI,BUFA
		CALL  RADIX_R
		MOV   BYTE PTR [SI],'H'
		POP   DS
		POP   ESI
		POP   EBX
		POP   EAX
		RET
convert  ENDP

RADIX_R   PROC  NEAR
		PUSH  CX
		PUSH  EDX
		XOR   CX,CX
LOP1:   XOR   EDX,EDX
		DIV   EBX
		PUSH  DX
		INC   CX
		OR    EAX,EAX
		JNZ   LOP1
LOP2:   POP   AX
		CMP   AL,10
		JB    L1
		ADD   AL,7
L1:     ADD   AL,30H
		MOV   [SI],AL
		INC   SI                   ;ָ��ָ����һ����Ԫ
		DEC   CX
		JNZ   LOP2
		POP   EDX
		POP   CX
		RET
RADIX_R   ENDP
_TEXT   ENDS
END