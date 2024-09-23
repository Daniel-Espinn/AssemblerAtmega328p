
.include "m328pdef.inc"

; Definir valores
.def TEMP = r16
.equ P1 = 0 ;el botón está conectado al pin 0 del puerto B
.equ P2 = 1 ;el botón está conectado al pin 1 del puerto B
.equ LED1 = 2 ;LED1 conectado al pin 2 del puerto B
.equ LED2 = 3 ;LED2 conectado al pin 3 del puerto B

   ; Inicializar el puerto B
   sbi DDRB, LED1 ;Configurar el pin del LED1 como salida
   sbi DDRB, LED2 ;Configurar el pin del LED2 como salida

   ; Configurar PB4 como entrada
   cbi DDRB, P1
    ; Habilitar la resistencia pull-up en PB4
   sbi PORTB, P1
    
   ; Configurar PB4 como entrada
   cbi DDRB, P2
   ; Habilitar la resistencia pull-up en PB4
   sbi PORTB, P2

inicio:
    ; Leer el estado del botón 2
    sbis PINB, P2
    rjmp P2_ON
    rjmp P2_OFF
P2_ON:
   sbis PINB, P1
   rjmp LED_OFF
   rjmp AMBOS_LED

P2_OFF:
   sbic	PINB, P1
   rjmp	inicio
   rjmp	LED_ON
    
LED_ON:
   sbic PORTB, PB2
   rjmp LED1_ON
   rjmp LED2_ON
   
LED1_ON:
   sbi PORTB, LED1
   rjmp esperar_a_soltar_p1

LED2_ON:
   sbi PORTB, LED2
   rjmp esperar_a_soltar_p1
 
LED_OFF:
   sbic PORTB, PB2
   rjmp LED1_OFF
   rjmp LED2_OFF

LED1_OFF:
   cbi PORTB, LED1
   rjmp esperar_a_soltar_p1

LED2_OFF:
   cbi PORTB, LED1
   rjmp esperar_a_soltar_p1

AMBOS_LED:
   sbi PORTB, LED1
   sbi PORTB, LED2
   rjmp esperar_a_soltar_p1
   
esperar_a_soltar_p1:
   sbis	PINB, P1
   rjmp	inicio
   rjmp esperar_a_soltar_p1
   
esperar_a_soltar_p2:
   sbis	PINB, P2
   rjmp	inicio
   rjmp esperar_a_soltar_p2
    


<______________________Delay 0.5seg___________________>

; Delay 8 000 000 cycles
; 500ms at 16.0 MHz

    ldi  r19, 41
    ldi  r20, 150
    ldi  r21, 128
L1: dec  r21
    brne L1
    dec  r20
    brne L1
    dec  r19
    brne L1


