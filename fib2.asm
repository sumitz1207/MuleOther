.orig x3000

    LD R0, VAL			; R0 STORES N
    LD R6, STACK		; R6 IS STACK POINTER

    ;CALLER
    ADD R6, R6, -1		; LEAVE SPACE FOR ARG
    STR R0, R6, 0		; STORE ARG
    LD R2, FIBPTR		; LOAD FIBPTR TO R2
    JSRR R2
    LDR R0, R6, 0		; GET ANSWER
    ST R0, ANS
    HALT

    STACK .fill x6000
    VAL .fill 6
    ANS .blkw 1
    FIBPTR .fill FIB

;CALLEE
FIB
    ADD R6, R6, -5		; LEAVE SPACE FOR RV, RA, OFP, SR1, SR2
    STR R5, R6, 2		; STORE OFP
    STR R2, R6, 0 		; STORE R2
    STR R1, R6, 1 		; STORE R1
    ADD R5, R6, 1		; UPDATE R5
    STR R7, R5, 2		; STORE RETURN ADDRESS
    LDR R1, R5, 4		; R1 STORES N
    BRZ	ZERO
    ADD R3, R1, -1		; R3 = R1 - 1
    BRZ ONE
    BRNP RECURSE

ZERO
    STR R1, R5, 3		; STORE RETURN VALUE
    BRNZP EXIT

ONE STR R1, R5, 3
    BRNZP EXIT

RECURSE
    ADD R1, R1, -1		; DECREMENT N BY 1
    ADD R6, R6, -1		; LEAVE SPACE FOR ARG
    STR R1, R6, 0		; STORE N-1 IN ARG
    JSR FIB
    LDR R1, R6, 0		; LOAD RETURN VALUE IN R1
    ADD R6, R5, -1		; RESTORE STACK POINTER
    LDR R2, R5, 4		; LOAD N IN R2
    ADD R2, R2, -2		; DECREMENT N BY 2
    ADD R6, R6, -1 		; LEAVE SPACE FOR ARG
    STR R2, R6, 0		; STORE N-2 IN ARG
    JSR FIB
    LDR R2, R6, 0		; LOAD RETURN VALUE IN R2
    ADD R2, R1, R2		; R2 = FIB(N-1) + FIB(N-2)
    STR R2, R5, 3
    BRNZP EXIT

EXIT
    LDR R1, R5, 0 		; LOAD R1
    LDR R2, R5, -1 		; LOAD R2
    LDR R7, R5, 2 		; RESTORE RA
    ADD R6, R5, 3 		; R6 POINTS TO RV
    LDR R5, R5, 1 		; RESTORE OLD FRAME POINTER
    RET


.end