<---------------------LED PARPADEA----------------------->
.include "m328pdef.inc"

.def temp = r16
.def counter = r17
.org 0x00

comienzo:
    ; Configurar PB5 como salida
    sbi DDRB, PB5

main:
    ; Encender el LED
    sbi PORTB, PB5
    ; Esperar un segundo
    ldi counter, 61 		;Aproximadamente un segundo a 16MHz
    call delay

    ; Apagar el LED
    cbi PORTB, PB5

    ; Esperar un segundo
    ldi counter, 61 		;Aproximadamente un segundo a 16MHz
    call delay

    rjmp main

delay:
    ; Delay de 16ms
    ldi temp, 250
delay1:
    dec temp
    brne delay1

    ; Decrementar el contador de segundos
    dec counter
    brne delay
    ret

<---------------------LED PARPADEA CUANDO PULSO BOTON----------------------->
.include "m328pdef.inc"

.def temp = r16
.def counter = r17

.org 0x0000
    rjmp init

init:
    ; Configurar PB5 como salida
    sbi DDRB, PB5
    ; Configurar PB4 como entrada
    cbi DDRB, PB4
    ; Habilitar la resistencia pull-up en PB4
    sbi PORTB, PB4

main:
    ; Leer el estado del botón
    sbic PINB, PB4
    rjmp main

    ; Encender el LED
    sbi PORTB, PB5

    ; Esperar un segundo
    ldi counter, 61 ; Aproximadamente un segundo a 16MHz
    call delay

    ; Apagar el LED
    cbi PORTB, PB5

    ; Esperar un segundo
    ldi counter, 61 ; Aproximadamente un segundo a 16MHz
    call delay

    rjmp main

delay:
    ; Delay de 16ms
    ldi temp, 250
delay1:
    dec temp
    brne delay1

    ; Decrementar el contador de segundos
    dec counter
    brne delay

    ret

<----------------LED PARPADEA CUANDO PULSO BOTON POR PRIMERA VEZ Y A  LA SEGUNDA SE APAGA------------------>

