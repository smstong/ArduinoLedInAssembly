;===============================================================
; file: led.asm
; desc: This is a simple demo code to blink Arduino Uno R3's 
;       builtin LED connected to Pin 13 ( the 5th bit of PortB )
;===============================================================

; directive to tell avr-as to put next instruction at 0x0000 on ROM space
.ORG 0x0000

; directives to define const
.equ SPL, 0x3d			
.equ SPH, 0x3e
.equ DDRB, 0x04
.equ PORTB, 0x05

; initialize stack by configuring SPH,SPL 
; to the last data ram location 0x08FF
; The stack must be setup before any CALL instructions
ldi r16, 0x08
out SPH, r16
ldi r16, 0xFF
out SPL, r16

; Configure Port B to work in output mode
ldi r16, 0xFF
out DDRB, r16
            
; Turn on/off LED indefinately
LOOP:
  sbi PORTB, 5       ; switch on the LED
  rcall QDELAY       ; wait for one fourth second
  cbi PORTB, 5       ; switch it off 
  rcall QDELAY       ; wait for one fourth second
  rjmp LOOP 

; The is a function for delaying 250 ms
QDELAY:
        LDI R20, 16
D0:
        LDI R21, 200
D1:
        LDI R22, 250
D2:
        NOP
        DEC R22
        BRNE D2
        DEC R21
        BRNE D1
        DEC R20
        BRNE D0
        RET
