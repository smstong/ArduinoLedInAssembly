Playing Arduino: Programming Arduino UNO with Assembly language without GUI on Linux 

More info can be found at https://www.linuxexam.net/2020/07/playing-arduino-programming-arduino-uno.html

# Run it
$ make deploy
Then you'll see the built-in LED on your Arduino UNO R3 board blinking happily forever!

# Some notes
* .equ has different syntax in AVR Studio on Windows and avr-as on Linux.
AVR Studio: .equ SPH = 0x3e
avr-as: .equ SPH, 0x3e

* Both avr-as and avr-ld have the same default output file name, a.out. This will cause a problem if you don't use a specific output file name.
         $ avr-as -mmcu atmega328p led.asm
         $ avr-ld a.out
         a.out: file not recognized: File truncated

         This is because the avr-ld now uses a.out as both input and output file name!

* avr-objcopy works on object file too, but it's not what we want.
         $ file led.o
         led.o: ELF 32-bit LSB relocatable, Atmel AVR 8-bit, version 1 (SYSV), not stripped

         $ avr-objcopy -O ihex led.o led.hex

         However, this is NOT what you want! led.o has unresolved addresses (marked as all 0). The led.hex generated has instructions with addresses operand as 0 instead! 
