;===============================================================================
; Programa: Contador 0-9 y A-Z en Display 7 Segmentos
; Microcontrolador: ATmega8515
; Descripción: Muestra una secuencia de dígitos del 0 al 9 seguidos de
;              letras A-Z en un display de 7 segmentos usando una tabla
;              almacenada en memoria de programa
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
    OUT     DDRA, R16           ; Configurar Puerto A como salida

;-------------------------------------------------------------------------------
; Programa Principal
; Descripción: Lee secuencialmente valores de la tabla y los muestra en
;              el Puerto A con retardo entre cada valor
;-------------------------------------------------------------------------------
PRINCIPAL:
    LDI     R16, 0              ; Inicializar índice en 0

CICLO:
    ; Calcular dirección en la tabla
    LDI     R30, LOW(TABLA)     ; Cargar byte bajo de dirección de tabla
    LDI     R31, HIGH(TABLA)    ; Cargar byte alto de dirección de tabla
    ADD     R30, R16            ; Sumar índice a dirección base
    BRCC    SIGUE               ; Si no hay carry, continuar
    INC     R31                 ; Si hay carry, incrementar byte alto

SIGUE:
    LPM     R17, Z              ; Leer byte de memoria de programa
    OUT     PORTA, R17          ; Mostrar patrón en Puerto A
    RCALL   TIEMPO              ; Llamar rutina de retardo
    INC     R16                 ; Incrementar índice
    CPI     R16, 30             ; Comparar con tamaño de tabla
    BREQ    PRINCIPAL           ; Si llegó al final, reiniciar
    RJMP    CICLO               ; Continuar con siguiente valor

;-------------------------------------------------------------------------------
; Subrutina: Retardo de Tiempo
; Descripción: Genera un retardo de aproximadamente 120ms
; Registros usados: R20, R21, R22
;-------------------------------------------------------------------------------
TIEMPO:
    LDI     R20, 7              ; Inicializar contador externo
BUCLE_T:
    LDI     R21, 150            ; Inicializar contador medio
BUCLE_Y:
    LDI     R22, 128            ; Inicializar contador interno
BUCLE_X:
    DEC     R22                 ; Decrementar contador interno
    BRNE    BUCLE_X             ; Repetir si no es cero
    DEC     R21                 ; Decrementar contador medio
    BRNE    BUCLE_Y             ; Repetir si no es cero
    DEC     R20                 ; Decrementar contador externo
    BRNE    BUCLE_T             ; Repetir si no es cero
    RET                         ; Retornar de subrutina

;-------------------------------------------------------------------------------
; Tabla de Códigos para Display 7 Segmentos
; Descripción: Contiene los códigos para mostrar 0-9 y A-Z en display
;              de 7 segmentos con lógica inversa (ánodo común)
;-------------------------------------------------------------------------------
TABLA:
    ; Dígitos 0-9
    .DB 0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8
    .DB 0x80, 0x98
    ; Letras A-F
    .DB 0x88, 0x83, 0xC6, 0xA1, 0x86, 0x8E
    ; Letras G-Z (selección de caracteres visibles)
    .DB 0x90, 0x89, 0xCF, 0xE1, 0xC7, 0xAB, 0xAA, 0xA3
    .DB 0x8C, 0x98, 0xAF, 0x92, 0xE3, 0x91