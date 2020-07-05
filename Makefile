all: led.hex

led.hex: led.elf
	# generate Intel Hex format file
	avr-objcopy -O ihex $< $@

led.elf: led.o
	# link object file to executable file
	avr-ld -o $@ $<

led.o: led.asm
	# assembly source code to elf object file
	avr-as -mmcu atmega328p -o $@ $<

clean:
	rm -f *.o *.elf *.hex

deploy: led.hex
	avrdude -F -V -c arduino -p ATMEGA328p \
	   	-P /dev/ttyACM0 \
		-b 115200 \
		-U flash:w:$^

