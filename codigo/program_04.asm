;===============================================================================
; Programa: Desplazamiento Bidireccional de Bit
; Microcontrolador: ATmega8515
; Descripción: Desplaza un bit de derecha a izquierda y luego de izquierda
;              a derecha de forma continua en el Puerto A
; Autor: Equipo 1
; Fecha: 21/10/2025
;===============================================================================

.INCLUDE "m8515def.inc"

;-------------------------------------------------------------------------------
; Inicialización del Stack Pointer
;-------------------------------------------------------------------------------
INICIO:
    LDI     R16, HIGH(RAMEND)   ; Cargar byte alto de RAMEND (0x02)
    OUT     SPH, R16            ; Configurar Stack Pointer High
    LDI     R16, LOW(RAMEND)    ; Cargar byte bajo de RAMEND (0x5F)
    OUT     SPL, R16            ; Configurar Stack Pointer Low

;-------------------------------------------------------------------------------
; Configuración de Puertos
;-------------------------------------------------------------------------------
    LDI     R16, 0xFF           ; Cargar 0xFF en R16
    OUT     DDRA, R16           ; Configurar Puerto A como salida

;-------------------------------------------------------------------------------
; Bucle de Desplazamiento de Derecha a Izquierda
;-------------------------------------------------------------------------------
DERECHA:
    LDI     R16, 0b10000000     ; Iniciar con bit en posición 7
CICLO_DER:
    LSL     R16                 ; Desplazar bit a la izquierda
    BREQ    IZQUIERDA           ; Si resultado es cero, cambiar dirección
    OUT     PORTA, R16          ; Mostrar patrón en Puerto A
    RCALL   TIEMPO              ; Llamar rutina de retardo
    RJMP    CICLO_DER           ; Repetir desplazamiento

;-------------------------------------------------------------------------------
; Bucle de Desplazamiento de Izquierda a Derecha
;-------------------------------------------------------------------------------
IZQUIERDA:
    LDI     R16, 0b00000001     ; Iniciar con bit en posición 0
CICLO_IZQ:
    LSR     R16                 ; Desplazar bit a la derecha
    BREQ    DERECHA             ; Si resultado es cero, cambiar dirección
    OUT     PORTA, R16          ; Mostrar patrón en Puerto A
    RCALL   TIEMPO              ; Llamar rutina de retardo
    RJMP    CICLO_IZQ           ; Repetir desplazamiento

;-------------------------------------------------------------------------------
; Subrutina: Retardo de Tiempo
; Descripción: Genera un retardo de aproximadamente 120ms
; Registros usados: R24, R25, R26
;-------------------------------------------------------------------------------
TIEMPO:
    LDI     R24, 7              ; Inicializar contador externo
    LDI     R25, 150            ; Inicializar contador medio
    LDI     R26, 128            ; Inicializar contador interno
L1:
    DEC     R26                 ; Decrementar contador interno
    BRNE    L1                  ; Repetir si no es cero
    DEC     R25                 ; Decrementar contador medio
    BRNE    L1                  ; Repetir si no es cero
    DEC     R24                 ; Decrementar contador externo
    BRNE    L1                  ; Repetir si no es cero
    RET                         ; Retornar de subrutina