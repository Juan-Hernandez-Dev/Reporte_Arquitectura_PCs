;===============================================================================
; Programa: Manejo de Interrupción Externa INT0
; Microcontrolador: ATmega8515
; Descripción: Contador 0-9 que se interrumpe al detectar flanco descendente
;              en INT0, mostrando secuencia de letras A-F
; Autor: Equipo 1
; Fecha: 03/11/2025
;===============================================================================

.INCLUDE "m8515def.inc"

;-------------------------------------------------------------------------------
; Vector de Reset
;-------------------------------------------------------------------------------
.org 0x000
    RJMP    PRINCIPAL           ; Saltar al programa principal

;-------------------------------------------------------------------------------
; Vector de Interrupción Externa 0
;-------------------------------------------------------------------------------
.org 0x001
    RJMP    INT_EXT_0           ; Saltar a rutina de interrupción INT0

;-------------------------------------------------------------------------------
; Programa Principal
;-------------------------------------------------------------------------------
.org 0x020

PRINCIPAL:
    ; Configuración de puertos
    LDI     R16, 0xFF           ; Cargar 0xFF en R16
    OUT     DDRA, R16           ; Configurar Puerto A como salida
    OUT     DDRB, R16           ; Configurar Puerto B como salida

    LDI     R17, 0x00           ; Cargar 0x00 en R17
    OUT     DDRD, R17           ; Configurar Puerto D como entrada
    OUT     PORTD, R16          ; Activar resistencias pull-up en Puerto D

    ; Inicialización del Stack Pointer
    LDI     R16, HIGH(RAMEND)   ; Cargar byte alto de RAMEND
    OUT     SPH, R16            ; Configurar Stack Pointer High
    LDI     R16, LOW(RAMEND)    ; Cargar byte bajo de RAMEND
    OUT     SPL, R16            ; Configurar Stack Pointer Low

    ; Configuración de interrupción INT0 por flanco descendente
    LDI     R16, 0b00000010     ; ISC01=1, ISC00=0 (flanco descendente)
    OUT     MCUCR, R16          ; Configurar modo de interrupción

    LDI     R16, 0b01000000     ; INT0=1 (habilitar INT0)
    OUT     GICR, R16           ; Habilitar interrupción externa 0

    SEI                         ; Habilitar interrupciones globales

;-------------------------------------------------------------------------------
; Bucle Principal - Contador 0-9
;-------------------------------------------------------------------------------
INICIO:
    LDI     R16, 0x00           ; Inicializar contador en 0

CICLO:
    ; Calcular dirección en tabla de números
    LDI     R31, HIGH(TABLA_NUMEROS << 1)
    LDI     R30, LOW(TABLA_NUMEROS << 1)
    ADD     R30, R16            ; Sumar índice a dirección base
    BRCC    SIGUE               ; Si no hay carry, continuar
    INC     R31                 ; Si hay carry, incrementar byte alto

SIGUE:
    LPM     R17, Z              ; Leer código de display desde tabla
    OUT     PORTA, R17          ; Mostrar en Puerto A
    OUT     PORTB, R17          ; Mostrar en Puerto B
    RCALL   UN_SEG              ; Retardo de 1 segundo
    INC     R16                 ; Incrementar contador
    CPI     R16, 0x0A           ; Comparar con 10
    BREQ    INICIO              ; Si llegó a 10, reiniciar
    RJMP    CICLO               ; Continuar conteo

;-------------------------------------------------------------------------------
; Subrutina: Retardo de 1 Segundo
; Registros usados: R20, R21, R22
;-------------------------------------------------------------------------------
UN_SEG:
    LDI     R20, 7              ; Inicializar contador externo
    LDI     R21, 150            ; Inicializar contador medio
    LDI     R22, 128            ; Inicializar contador interno
L1:
    DEC     R22                 ; Decrementar contador interno
    BRNE    L1                  ; Repetir si no es cero
    DEC     R21                 ; Decrementar contador medio
    BRNE    L1                  ; Repetir si no es cero
    DEC     R20                 ; Decrementar contador externo
    BRNE    L1                  ; Repetir si no es cero
    RET                         ; Retornar de subrutina

;-------------------------------------------------------------------------------
; Rutina de Servicio de Interrupción: INT0
; Descripción: Muestra secuencia de letras A-F cuando se detecta interrupción
;-------------------------------------------------------------------------------
INT_EXT_0:
    ; Guardar contexto
    PUSH    R30                 ; Guardar R30 en stack
    PUSH    R31                 ; Guardar R31 en stack
    PUSH    R20                 ; Guardar R20 en stack

    LDI     R18, 0x00           ; Inicializar índice de letras

CICLO2:
    ; Calcular dirección en tabla de letras
    LDI     R31, HIGH(TABLA_LETRAS << 1)
    LDI     R30, LOW(TABLA_LETRAS << 1)
    ADD     R30, R18            ; Sumar índice a dirección base
    BRCC    SIGUE2              ; Si no hay carry, continuar
    INC     R31                 ; Si hay carry, incrementar byte alto

SIGUE2:
    LPM     R19, Z              ; Leer código de display desde tabla
    OUT     PORTA, R19          ; Mostrar en Puerto A
    OUT     PORTB, R19          ; Mostrar en Puerto B
    RCALL   UN_SEG              ; Retardo de 1 segundo
    INC     R18                 ; Incrementar índice
    CPI     R18, 0x06           ; Comparar con 6 (letras A-F)
    BREQ    FIN_IEO             ; Si llegó a 6, finalizar
    RJMP    CICLO2              ; Continuar con siguiente letra

FIN_IEO:
    ; Restaurar contexto
    POP     R20                 ; Recuperar R20 del stack
    POP     R31                 ; Recuperar R31 del stack
    POP     R30                 ; Recuperar R30 del stack
    RETI                        ; Retornar de interrupción

;-------------------------------------------------------------------------------
; Tablas de Datos
;-------------------------------------------------------------------------------
TABLA_NUMEROS:
    .DB 0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x98

TABLA_LETRAS:
    .DB 0x88, 0x83, 0xC6, 0xA1, 0x86, 0x8E