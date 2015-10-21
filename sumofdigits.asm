;;===============================
;;Name:Andrew Scheinbach
;;===============================

.orig x3000

;;===============================
;;Do not change anything in MAIN
;;===============================
MAIN
LD R6, STACK 	; initialize stack pointer
LD R0, X 		; load X
ADD R6, R6, -1 	; move the stack pointer
STR R0, R6, 0 	; push X into the stack
JSR SUMOFDIGITS	; call recursive function
LDR R0, R6, 0 	; pop from the stack
ADD R6, R6, 2 	; move the stack pointer
ST R0, ANSWER 	; store the result at ANSWER
HALT

X .fill 2110
ANSWER .fill 0
STACK .fill xF000

SUMOFDIGITS
;;==========================
    ADD R6,R6,-2 	;Room for Return Address and Return Value
    STR R7,R6,0 	;Store Return Address
    ADD R6,R6,-1	;Room for Old Frame Pointer
    STR R5,R6,0 	;Store Old FP on Stack
    ADD R6,R6,-1 	;Room for Local Variable
    ADD R5,R6,0 	;Copy Stack Pattern to FP
    ADD R6,R6,-2 	;Room for saved Registers
    STR R0,R6,1 	;Save R0
    STR R1,R6,0 	;Save R1
;WORK
    AND R1,R1,0 	;Clears R1
    LDR R0,R5,4		;Load X into R0
    BRz DON 		;End of Recursion
    ADD R1,R1,10 	;Makes R1=10
    JSR UDIV 		;R0=X/10, R1=X%10
    ADD R6,R6,-1 	;Room for X/10
    STR R0,R6,0 	;Put X/10 on Stack
    JSR SUMOFDIGITS ;Does SumOfDigits(X/10)
    LDR R0,R6,0 	;Loads recursed RV into R0
    ADD R0,R1,R0 	;Adds Sumofdigits(X/10)+X%10
DON STR R0,R5,3 	;Store value in Return Value
    LDR R0,R5,-1 	;Restore R0
    LDR R1,R5,-2 	;Restore R1
    ADD R6,R5,1 	;SP ->Old FP
    LDR R5,R6,0		;Restore FP
    LDR R7,R6,1 	;Restore RA
    ADD R6,R6,2 	;SP -> Return Value
    RET


;;==========================

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
UDIV
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
.end
