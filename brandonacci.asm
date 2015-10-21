;;===============================
;;Name: Brent McCorvey
;;===============================

.orig x3000
    LD R6, STACK
    JSR MAIN
    HALT

; Do not modify the assembly code below
; int main(void)
; {
;   int answer = brandonacci(n);
;   return 1;
; }
MAIN
    ADD R6, R6, -3
    STR R7, R6, 1
    STR R5, R6, 0
    ADD R5, R6, -1

    AND R0, R0, 0
    ADD R0, R0, 1
    STR R0, R5, 3
    LD R0, N
    ADD R6, R6, -1
    STR R0, R6, 0
    LD R0, BRANDONACCILOC

    JSRR R0

    LDR R0, R6, 0
    ST R0, ANSWER

    ADD R6, R5, 1
    LDR R5, R6, 0
    LDR R7, R6, 1
    ADD R6, R6, 2
    RET

N .fill 0
STACK .fill xF000
ANSWER .blkw 1
BRANDONACCILOC .fill BRANDONACCI
.blkw x100 ; Do not touch

BRANDONACCI
;;======================
;;Your subroutine here:
;;======================

; You should not be loading from any of the labels above in this function.  Follow the calling convention.

    ADD R6, R6, -3	;Set up room for stack frame
    STR R5, R6, 0  	;Set up OFP
    STR R7, R6, 1  	;Set up return address
    ADD R5, R6, -1 	;Set up FP to first local

    ADD R6, R5, -3	;Move r6 pointer to top of stack for storing values
    STR R0, R6, 1
    STR R1, R6, 0
    LDR R0, R5, 4	;Get n
    ADD R0, R0, 15	;if(n<=-15)
    BRp ELSE

    LDR R0, R5, 4	;Get n
    AND R1, R1, 0
    ADD R1, R1, 3	;Set up division by 3
    JSR UDIV
    NOT R0, R0
    ADD R0, R0, 1	;Negate answer
    ADD R0, R0, 15
    ADD R0, R0, 6	;Add 21

    BR RETURN

ELSE    ADD R6, R6, -1
    LDR R0, R5, 4	;Get n
    ADD R0, R0, -1	;brandonacci(n-1)
    STR R0, R6, 0

    JSR BRANDONACCI

    LDR R0, R6, 0
    STR R0, R5, 0
    LDR R0, R5, 4	;Get n
    ADD R0, R0, -5	;brandonacci(n-5)
    ADD R6, R6, -1
    STR R0, R6, 0

    JSR BRANDONACCI

    LDR R0, R6, 0	;Logic for else return statement
    STR R0, R5, -1
    LDR R0, R5, 0
    AND R1, R1, 0
    ADD R1, R1, 2	;Set up 2 for division
    JSR UDIV
    LDR R1, R5, -1
    ADD R1, R1, R1
    NOT R1, R1	;Negate c2
    ADD R1, R1, 1
    ADD R0, R0, R1	;return statement without the 12
    ADD R0, R0, -12	;Subtract 12

RETURN 	STR R0, R5, 3	;Move pointers back to previous positions and point r6 at return value
    LDR R7, R5, 2
    ADD R6, R5, 0
    LDR R5, R6, 1
    ADD R6, R6, 3
    RET


;;===============================================================================================================
;; You should not modify any code beyond this point. (You may add some lines at the bottom after this subroutine)
;;===============================================================================================================
;; A working division/modulo subroutine for positive numbers only.
;;
;; This subroutine takes two arguments in R0 and R1, and has two return values
;; also in R0 and R1. For clarity the argument in R0 will be referred to as X,
;; and the argument in R1 will be referred to as Y.
;;
;; The result of this subroutine is that R0 will contain X divided by Y using
;; integer devision and R1 will contain the remainder of that devision.
;; R0 = X/Y
;; R1 = X%Y
;;
;; Preconditions:
;;  R6 is the stack pointer and points to the last used stack location
;;  R0 is between 0 and 32767
;;  R1 is between 1 and 32767
;;
;; Postconditions:
;;  R0 <- R0 / R1
;;  R1 <- R0 % R1
;;
UDIVSUB
.fill x0042
.fill x1DBB
.fill x7F84
.fill x7B83
.fill x7982
.fill x7781
.fill x7580
.fill xEA2E
.fill x947F
.fill x14A1
.fill x56E0
.fill x16FF
.fill x16E1
.fill x1943
.fill x7500
.fill x1482
.fill x09FB
.fill x5260
.fill x1943
.fill x6500
.fill x1480
.fill x0804
.fill x10A0
.fill x1930
.fill x6500
.fill x1242
.fill x16FF
.fill x07F6
.fill x1460
.fill x1220
.fill x10A0
.fill x6580
.fill x6781
.fill x6982
.fill x6B83
.fill x6F84
.fill x1DA5
.fill xC1C0
.fill x0001
.fill x0002
.fill x0004
.fill x0008
.fill x0010
.fill x0020
.fill x0040
.fill x0080
.fill x0100
.fill x0200
.fill x0400
.fill x0800
.fill x1000
.fill x2000
.fill x4000
.fill x8000
.fill x0000
.fill x0000
.fill x0000
.fill x0000
.fill x0000
.fill x0000
.fill x0000
.fill x0000
.fill x0000
.fill x0000
.fill x0000
.fill x0000
.fill x0000
.fill x0000
.fill x0000
.fill x0000

UDIV
ST R7, STASHR7
ADD R0, R0, 0;
BRn ANEG
ADD R1, R1, 0;
BRn BNEG
BR NOTNEG

ANEG
ADD R1, R1, 0;
BRn ABNEG

NOT R0, R0
ADD R0, R0, 1;
JSR UDIVSUB
BR NEGOUT

BNEG
NOT R1, R1
ADD R1, R1, 1;
JSR UDIVSUB
BR NEGOUT

ABNEG
NOT R0, R0
ADD R0, R0, 1;
NOT R1, R1
ADD R1, R1, 1;
JSR UDIVSUB
LD R7, STASHR7
RET

NEGOUT
NOT R0, R0
ADD R0, R0, 1
LD R7, STASHR7
RET

NOTNEG
JSR UDIVSUB
LD R7, STASHR7
RET

STASHR7 .fill x0000

.end
