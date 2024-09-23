.include "m328pdef.inc"
	.org	0x00
	rjmp	INICIO
	.org	0x0016
	rjmp	TMR_1


INICIO:
	sei
	ldi	R16, 0xFF
	out	DDRB, R16
	ldi	R17, 0x00
	out	PORTB, R17
	ldi	R16, 0x03
	out	DDRC, r16
	ldi	R17, 0x00
	out	PORTC, r17
	ldi	R16, 0x04
	out	DDRD, r16
	ldi	R17, 0x00
	out	PORTD, r17
	

	ldi	r17, 0x0A
	sts	TCCR1B, r17
	ldi r17, 0x00
	sts	TCCR1A, r17
	ldi r17, 0x36
	sts OCR1AH, r17	
	ldi	r17, 0xB0
	sts	OCR1AL,	r17
	ldi	r17, 0x02
	sts	TIMSK1, r17

	ldi	r20, 0x05
	sts	0x103, r20
	ldi	r20, 0x04
	sts	0x104, r20
	ldi	r20, 0x01
	sts	0x105, r20
	ldi	r20, 0x07
	sts	0x106, r20

BUCLE:
	rjmp BUCLE

NUM:
	sbrc r20, 0
	sbi PORTB, 1
	sbrs r20, 0
	cbi PORTB, 1
	
	sbrc r20, 1
	sbi PORTB, 3
	sbrs r20, 1
	cbi PORTB, 3
	
	sbrc r20, 2
	sbi PORTD, 2
	sbrs r20, 2
	cbi PORTD, 2
	
	sbrc r20, 3
	sbi PORTB, 2
	sbrs r20, 3
	cbi PORTB, 2
	ret


TMR_1:
	sbis PINC, 0
	rjmp centenas
	lds	r20, 0x104
	call NUM
	cbi	PORTC, 0
	sbi	PORTC, 1
	reti

centenas:
	sbis PINC, 1
	rjmp udemil
	lds	r20, 0x105
	call NUM
	cbi	PORTC, 1
	sbi	PORTB, 4
	reti

udemil:
	sbis PINB, 4
	rjmp unidades
	lds	r20, 0x103
	call NUM
	cbi	PORTB, 4
	sbi	PORTB, 0
	reti

unidades:
	lds	r20, 0x106
	call NUM
	cbi	PORTB, 0
	sbi	PORTC, 0
	reti