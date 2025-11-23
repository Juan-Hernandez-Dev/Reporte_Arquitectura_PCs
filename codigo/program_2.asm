
;===============================================================================
; Programa: Desplazamiento de Bit en Puerto A
; Microcontrolador: ATmega8515
; Descripción: Mueve un bit activo de izquierda a derecha en el Puerto A
;              con retardo entre cada posición
; Autor: Equipo 1
; Fecha: 10/13/2025
;===============================================================================

.INCLUDE "m8515def.inc"

;-------------------------------------------------------------------------------
; Configuración de Puertos
;-------------------------------------------------------------------------------
INICIO:
    LDI     R16, 0xFF           ; Cargar 0xFF en R16
    OUT     DDRA, R16           ; Configurar Puerto A como salida

;-------------------------------------------------------------------------------
; Inicialización de Registros con Patrones de Bits
;-------------------------------------------------------------------------------
    LDI     R16, 0b10000000     ; Bit 7 (0x80)
    LDI     R17, 0b01000000     ; Bit 6 (0x40)
    LDI     R18, 0x20           ; Bit 5
    LDI     R19, 0x10           ; Bit 4
    LDI     R20, 0x08           ; Bit 3
    LDI     R21, 0x04           ; Bit 2
    LDI     R22, 0x02           ; Bit 1
    LDI     R23, 0x01           ; Bit 0

;-------------------------------------------------------------------------------
; Bucle Principal - Desplazamiento de Derecha a Izquierda
;-------------------------------------------------------------------------------
CICLO:
    ; Posición 0 (Bit 7)
    OUT     PORTA, R16
    LDI     R26, 0x0A
CICLO3_0:
    LDI     R25, 0xFF
CICLO2_0:
    LDI     R24, 0xFF
CICLO1_0:
    DEC     R24
    BRNE    CICLO1_0
    DEC     R25
    BRNE    CICLO2_0
    DEC     R26
    BRNE    CICLO3_0

    ; Posición 1 (Bit 6)
    OUT     PORTA, R17
    LDI     R26, 0x0A
CICLO3_1:
    LDI     R25, 0xFF
CICLO2_1:
    LDI     R24, 0xFF
CICLO1_1:
    DEC     R24
    BRNE    CICLO1_1
    DEC     R25
    BRNE    CICLO2_1
    DEC     R26
    BRNE    CICLO3_1

    ; Posición 2 (Bit 5)
    OUT     PORTA, R18
    LDI     R26, 0x0A
CICLO3_2:
    LDI     R25, 0xFF
CICLO2_2:
    LDI     R24, 0xFF
CICLO1_2:
    DEC     R24
    BRNE    CICLO1_2
    DEC     R25
    BRNE    CICLO2_2
    DEC     R26
    BRNE    CICLO3_2

    ; Posición 3 (Bit 4)
    OUT     PORTA, R19
    LDI     R26, 0x0A
CICLO3_3:
    LDI     R25, 0xFF
CICLO2_3:
    LDI     R24, 0xFF
CICLO1_3:
    DEC     R24
    BRNE    CICLO1_3
    DEC     R25
    BRNE    CICLO2_3
    DEC     R26
    BRNE    CICLO3_3

    ; Posición 4 (Bit 3)
    OUT     PORTA, R20
    LDI     R26, 0x0A
CICLO3_4:
    LDI     R25, 0xFF
CICLO2_4:
    LDI     R24, 0xFF
CICLO1_4:
    DEC     R24
    BRNE    CICLO1_4
    DEC     R25
    BRNE    CICLO2_4
    DEC     R26
    BRNE    CICLO3_4

    ; Posición 5 (Bit 2)
    OUT     PORTA, R21
    LDI     R26, 0x0A
CICLO3_5:
    LDI     R25, 0xFF
CICLO2_5:
    LDI     R24, 0xFF
CICLO1_5:
    DEC     R24
    BRNE    CICLO1_5
    DEC     R25
    BRNE    CICLO2_5
    DEC     R26
    BRNE    CICLO3_5

    ; Posición 6 (Bit 1)
    OUT     PORTA, R22
    LDI     R26, 0x0A
CICLO3_6:
    LDI     R25, 0xFF
CICLO2_6:
    LDI     R24, 0xFF
CICLO1_6:
    DEC     R24
    BRNE    CICLO1_6
    DEC     R25
    BRNE    CICLO2_6
    DEC     R26
    BRNE    CICLO3_6

    ; Posición 7 (Bit 0)
    OUT     PORTA, R23
    LDI     R26, 0x0A
CICLO3_7:
    LDI     R25, 0xFF
CICLO2_7:
    LDI     R24, 0xFF
CICLO1_7:
    DEC     R24
    BRNE    CICLO1_7
    DEC     R25
    BRNE    CICLO2_7
    DEC     R26
    BRNE    CICLO3_7

    RJMP    CICLO               ; Repetir secuencia infinitamente
    