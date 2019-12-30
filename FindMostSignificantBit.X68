*-----------------------------------------------------------
* Title      :  HW5 #15
* Written by :  Kyle Dukart 
* Date       :  11/25/19
* Description:  Most significant bit finder
*-----------------------------------------------------------
CR  EQU $0D
LF  EQU $0A

    ORG    $1000
START:                  ; first instruction of program

* Put program code here

    MOVE.B  #14, D0
    LEA INPUTMSG,A1
    TRAP #15        ; ask user for input
    
    MOVE.B  #4, D0
    TRAP #15        ; get keyboard input into D1
    
    CLR D3          ; D3 is used as a counter
MSB_LOOP:
    MOVE.L D1, D2     ; make a working copy of input into D2
    AND.L #MASK, D2   ; mask the first bit of D2
    CMP.L   #MASK, D2   ; check if first bit is 1
    BEQ MSB_FOUND       ; if first bit is 1 jump to found
    ADDQ    #1, D3      ; add 1 to counter
    CMP     #31, D3     ; check if we are still in the loop
    LSL.L   #1, D1          ; shift the input number 1 bit to the left
    BNE MSB_LOOP        ; loop
    MOVE.L #-1, D4        ; if we exit loop without finding MSB, enter -1
    BRA OUTPUT          
    
MSB_FOUND:
    MOVE.L    #31, D4
    SUB.L     D3, D4      ; correct MSB counter by doing (31 - counter = MSB)

OUTPUT:
    MOVE.L D4, D2         ; answer is required to be in D2

    MOVE.B  #14, D0
    LEA OUTPUTMSG,A1
    TRAP #15        ; output message
    
    MOVE.B  #3, D0
    MOVE.L D2, D1
    TRAP #15               ; output answer


    SIMHALT             ; halt simulator

* Put variables and constants here

INPUTMSG DC.B 'Please enter a decimal number between 0 and 4294967295', CR, LF, 0
OUTPUTMSG DC.B 'The most significant bit is (-1 if not found):', CR, LF, 0


MASK    EQU     $80000000

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
