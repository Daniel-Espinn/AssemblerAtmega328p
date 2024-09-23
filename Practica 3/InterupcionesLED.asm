.include "m328pdef.inc"

rjmp	inicio
		.equ	P1 = 4
		.equ	P2 = 4
		.equ	LED1 = 3
		.equ	LED2 = 3
		.org	0x0006
		rjmp	PC_INT0
		.org	0x000A
		rjmp	PC_INT2
      
inicio:
		SEI
		LDI 	r17, 0x05
		STS 	PCICR, r17
		LDI 	r17, 0x10
		STS 	PCMSK0, r17
		LDI 	r17, 0x10
		STS 	PCMSK2, r17
		; Inicializar el puerto B
		sbi 	DDRB, LED1 ;Configurar el pin del LED1 como salida
		sbi 	DDRD, LED2 ;Configurar el pin del LED2 como salida
		; Configurar PB4 como entrada
		cbi 	DDRB, P1
		; Habilitar la resistencia pull-up en PB4
		sbi 	PORTB, P1

		; Configurar PB4 como entrada
		cbi 	DDRD, P2
		; Habilitar la resistencia pull-up en PB4
		sbi 	PORTD, P2

		;B1 = Bit C
		;B2 = Bit H
		;B3 = Bit T
		;B4 = R16

bucle:
		sei
		brts	AMBOS_LED
		rjmp 	bucle
   
LED1_ON:
		seh
		sbi 	PORTB, LED1
		ret

LED2_ON:
		clh
		sbi 	PORTD, LED2
		ret

LED1_OFF:
		ldi		r22, 0xFF
		cbi 	PORTB, LED1
		ret

LED2_OFF:
		ldi		r22, 0x00
		cbi 	PORTD, LED2
		ret

FIN_P1:
		sec
		ret
      
AMBOS_LED:
		sbi 	PORTB, LED1
		sbi	 	PORTD, LED2
		call	RET_2S
		cbi 	PORTB, LED1
		cbi 	PORTD, LED2
		clt
		ret
   
PC_INT0:
		call 	RET_05S
		sbic	PINB, P1	;Flanco de Bajada
		rjmp	FIN_P1
		clc
		brhc	LED1_ON
		rjmp	LED2_ON
		reti
 
PC_INT2:
		call 	RET_05S
		sbis	PIND, P2	;Flanco de Subida
		reti
		brcc	AMBOS_LED
		sbrc	R22, 1 
		rjmp 	LED2_OFF
		rjmp	LED1_OFF
		reti
    
; 500ms at 16.0 MHz

RET_2S:
		call	RET_05S
		call	RET_05S
		call	RET_05S  
		call	RET_05S
		ret

RET_05S:
		ldi		r19, 41
		ldi 	r20, 150
		ldi 	r21, 128
		rjmp	L1
		ret

L1: 
		dec	r21
		brne 	L1
		dec  	r20
		brne 	L1
		dec  	r19
		brne 	L1
		ret
