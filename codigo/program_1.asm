
;===============================================================================
; Programa: Lectura de Puerto B y Escritura en Puerto A
; Microcontrolador: ATmega8515
; Descripción: Lee continuamente los datos del Puerto B y los refleja
;              en el Puerto A
; Autor: Equipo 1
;===============================================================================

.include "m8515def.inc"

;-------------------------------------------------------------------------------
; Configuración de Puertos
;-------------------------------------------------------------------------------
INICIO:
    LDI     R16, 0x00           ; Cargar 0 en R16
    OUT     DDRB, R16           ; Configurar Puerto B como entrada

    LDI     R16, 0xFF           ; Cargar 255 (0xFF) en R16
    OUT     DDRA, R16           ; Configurar Puerto A como salida
    OUT     PORTB, R16          ; Activar resistencias pull-up en Puerto B

;-------------------------------------------------------------------------------
; Programa Principal
;-------------------------------------------------------------------------------
LAZO:
    IN      R16, PINB           ; Leer datos del Puerto B
    OUT     PORTA, R16          ; Escribir datos en Puerto A
    RJMP    LAZO                ; Repetir indefinidamente
