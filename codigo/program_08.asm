;===============================================================================
; Programa: Contador Decimal 0-99
; Microcontrolador: ATmega8515
; Descripción: Cuenta de 0 a 99 mostrando el resultado en dos displays de
;              7 segmentos (unidades en Puerto A, decenas en Puerto B)
; Autor: Equipo 1
;===============================================================================

.INCLUDE "m8515def.inc"

;-------------------------------------------------------------------------------
; Inicialización del Stack Pointer
;-------------------------------------------------------------------------------
INICIO:
    LDI     R16, HIGH(RAMEND)   ; Cargar byte alto de RAMEND
    OUT     SPH, R16            ; Configurar Stack Pointer High
    LDI     R16, LOW(RAMEND)    ; Cargar byte bajo de RAMEND
    OUT     SPL, R16            ; Configurar Stack Pointer Low

;-------------------------------------------------------------------------------
; Configuración de Puertos
;-------------------------------------------------------------------------------
    LDI     R16, 0xFF           ; Cargar 0xFF en R16
    OUT     DDRA, R16           ; Configurar Puerto A como salida (unidades)
    OUT     DDRB, R16           ; Configurar Puerto B como salida (decenas)

;-------------------------------------------------------------------------------
; Programa Principal
; Descripción: Contador de dos dígitos que muestra unidades y decenas
;              en displays separados
;-------------------------------------------------------------------------------
PRINCIPAL:
    LDI     R17, 0              ; Inicializar contador de unidades
    LDI     R18, 0              ; Inicializar contador de decenas

;-------------------------------------------------------------------------------
; Bucle de Decenas
;-------------------------------------------------------------------------------
DECENAS:
    ; Obtener código para decenas desde tabla
    LDI     R31, HIGH(TABLA << 1)
    LDI     R30, LOW(TABLA << 1)
    ADD     R30, R18            ; Sumar índice de decenas
    BRCC    SIGUE1              ; Si no hay carry, continuar
    INC     R31                 ; Si hay carry, incrementar byte alto

SIGUE1:
    LPM     R16, Z              ; Leer código desde tabla
    OUT     PORTB, R16          ; Mostrar decenas en Puerto B

;-------------------------------------------------------------------------------
; Bucle de Unidades
;-------------------------------------------------------------------------------
UNIDADES:
    ; Obtener código para unidades desde tabla
    LDI     R31, HIGH(TABLA << 1)
    LDI     R30, LOW(TABLA << 1)
    ADD     R30, R17            ; Sumar índice de unidades
    BRCC    SIGUE2              ; Si no hay carry, continuar
    INC     R31                 ; Si hay carry, incrementar byte alto

SIGUE2:
    LPM     R16, Z              ; Leer código desde tabla
    OUT     PORTA, R16          ; Mostrar unidades en Puerto A

    RCALL   TIEMPO              ; Llamar rutina de retardo

    ; Incrementar unidades
    INC     R17                 ; Incrementar contador de unidades
    CPI     R17, 10             ; Comparar con 10
    BRNE    UNIDADES            ; Si no es 10, continuar con unidades

    ; Reiniciar unidades e incrementar decenas
    LDI     R17, 0              ; Reiniciar unidades a 0
    INC     R18                 ; Incrementar contador de decenas
    CPI     R18, 10             ; Comparar con 10
    BRNE    DECENAS             ; Si no es 10, continuar con decenas

    RJMP    PRINCIPAL           ; Reiniciar contador desde 0

;-------------------------------------------------------------------------------
; Subrutina: Retardo de Tiempo
; Descripción: Genera un retardo breve entre cambios de dígito
; Registros usados: R24, R25, R26
;-------------------------------------------------------------------------------
TIEMPO:
    LDI     R24, 2              ; Inicializar contador externo
    LDI     R25, 2              ; Inicializar contador medio
    LDI     R26, 2              ; Inicializar contador interno
L1:
    DEC     R26                 ; Decrementar contador interno
    BRNE    L1                  ; Repetir si no es cero
    DEC     R25                 ; Decrementar contador medio
    BRNE    L1                  ; Repetir si no es cero
    DEC     R24                 ; Decrementar contador externo
    BRNE    L1                  ; Repetir si no es cero
    RET                         ; Retornar de subrutina

;-------------------------------------------------------------------------------
; Tabla de Códigos para Display 7 Segmentos
; Descripción: Códigos para dígitos 0-9 con lógica inversa
;-------------------------------------------------------------------------------
TABLA:
    .DB 0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xB8, 0x80, 0x98