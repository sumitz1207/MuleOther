;;===============================
;;Name:Andrew Scheinbach
;;===============================

.orig x3000

MAIN
LD R6, STACK ;initialize stack pointer
;;=========================================================
LD R0,ARRAY 	;Load Array
LD R1,INDEX 	;Load Index
ADD R6,R6,-2 	;Move Stack Pointer
STR R0,R6,1 	;Push Array into stack
STR R1,R6,0 	;Push Index into stack
JSR HEIGHT 		;Calls function
LDR R0,R6,0 	;Pop from Stack
ADD R6,R6,3 	;Move the stack pointer
ST R0,ANSWER 	;Stores R0 into Answer
;;=========================================================

HALT

STACK .fill xF000
ARRAY .fill x6000   ; address of the array
INDEX .fill 1       ; starting index
ANSWER .fill 0      ; save your answer here

HEIGHT
;;=====================
    ADD R6,R6,-2 		;Room for RA and RV
    STR R7,R6,0 		;Store RA
    ADD R6,R6,-1 		;Room for OFP
    STR R5,R6,0 		;Store OFP on Stack
    ADD R6,R6,-2 		;Room for Local Variable left,right
    ADD R5,R6,1	 		;Copies SP+1 to FP(left height)
    ADD R6,R6,-2 		;Room for saved Registers
    STR R0,R6,1 		;Save R0
    STR R1,R6,0 		;Save R1
;WORK
    ADD R0,R1,R0 		;Gets (*(arr+index))
    ADD R6,R6,-1 		;Puts R6 at empty line if R0=0
    LDR R0,R0,0 		;Checks Value at R0 address, and puts it in R0
    BRz DON 			;End of Recursion
    ADD R6,R6,1 		;Puts R6 back at point if R0=/=0
    LDR R0,R5,5 		;Reinputs Array
    ADD R1,R1,R1 		;Doubles R1(index)
    JSR HEIGHT 			;Does left=height(arr,2*index)
    LDR R0,R6,0 		;Loads the Left value into R0
    STR R0,R5,0 		;Loads Left into local variable 1
    ADD R1,R1,1 		;Adds 1 to 2*Index
    LDR R0,R5,5 		;Reinputs Array
    ADD R6,R6,1 		;Moves stack forward 1 for 2nd height call
    JSR HEIGHT 			;Does right=height(arr,2*index+1)
    LDR R0,R6,0 		;Loads right value into R0
    STR R0,R5,-1 		;Load Right into local variable 2
    LDR R0,R5,0 		;Loads Left into R0
    LDR R1,R5,-1 		;Loads right into R1
    NOT R0,R0 			;Nots R0 for 2Comp
    ADD R0,R0,1 		;+1 R0 for 2Comp
    ADD R0,R1,R0 		;Does Right-Left
    BRn LBI				;Left>Right
    ADD R1,R1,1 		;Right+1
    ADD R0,R1,0 		;Puts Right+1 into R0
    BR DON
LBI	LDR R0,R5,0			;Reloads original Left value
    ADD R0,R0,1 		;Left+1
DON STR R0,R5,3 		;Stores height in RV
    LDR R0,R5,-2 		;Restores R0
    LDR R1,R5,-3 		;Restores R1
    ADD R6,R5,1 		;SP-> Old FP
    LDR R5,R6,0 		;Restore FP
    LDR R7,R6,1 		;Restore RA
    ADD R6,R6,2 		;SP->RV
    RET


;;=====================

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

.orig x6000
.fill 0
.fill 8     ;row 1
.fill 3     ;row 2
.fill 10
.fill 1     ;row 3
.fill 6
.fill 0
.fill 14
.fill 0     ;row 4
.fill 0
.fill 4
.fill 7
.fill 0
.fill 0
.fill 13
.fill 0
.fill 0     ;row 5
.fill 0
.fill 0
.fill 0
.fill 0
.fill 0
.fill 0
.fill 0
.fill 0
.fill 0
.fill 0
.fill 0
.fill 0
.fill 0
.fill 0
.fill 0
.end
