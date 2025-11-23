;===============================================================================
; Programa: Demostración de Operaciones con Stack
; Microcontrolador: ATmega8515
; Descripción: Demuestra el uso de las instrucciones PUSH y POP para
;              almacenar y recuperar datos del stack
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
; Programa Principal
; Descripción: Carga valores en registros, los guarda en el stack y luego
;              los recupera en orden inverso (LIFO - Last In First Out)
;-------------------------------------------------------------------------------
    ; Inicializar registros con valores de prueba
    LDI     R16, 0xAA           ; Cargar 0xAA en R16
    LDI     R17, 0xBB           ; Cargar 0xBB en R17
    LDI     R18, 0xCC           ; Cargar 0xCC en R18
    LDI     R19, 0xDD           ; Cargar 0xDD en R19

    ; Guardar valores en el stack
    PUSH    R16                 ; Guardar R16 en stack
    PUSH    R17                 ; Guardar R17 en stack
    PUSH    R18                 ; Guardar R18 en stack
    PUSH    R18                 ; Guardar R18 nuevamente
    PUSH    R19                 ; Guardar R19 en stack

    ; Recuperar valores del stack (orden inverso)
    POP     R16                 ; Recuperar último valor (0xDD) a R16
    POP     R17                 ; Recuperar valor (0xCC) a R17
    POP     R18                 ; Recuperar valor (0xCC) a R18
    POP     R19                 ; Recuperar valor (0xBB) a R19

;-------------------------------------------------------------------------------
; Bucle Infinito
;-------------------------------------------------------------------------------
CICLO:
    RJMP    CICLO               ; Bucle infinito