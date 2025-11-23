;===============================================================================
; Programa: Contador Hexadecimal en Display 7 Segmentos
; Microcontrolador: ATmega8515
; Descripción: Muestra los dígitos hexadecimales del 0 al F en un display
;              de 7 segmentos con lógica inversa (ánodo común)
; Autor: Equipo 1
; Fecha: 10/16/2025
;===============================================================================

.INCLUDE "m8515def.inc"

;-------------------------------------------------------------------------------
; Configuración de Puertos
;-------------------------------------------------------------------------------
INICIO:
    LDI     R16, 0xFF           ; Cargar 0xFF en R16
    OUT     DDRA, R16           ; Configurar Puerto A como salida

;-------------------------------------------------------------------------------
; Tabla de Códigos para Display 7 Segmentos (Lógica Inversa)
;-------------------------------------------------------------------------------
    LDI     R16, 0xC0           ; Código para dígito 0
    MOV     R13, R16
    LDI     R17, 0xF9           ; Código para dígito 1
    MOV     R14, R17
    LDI     R18, 0xA4           ; Código para dígito 2
    MOV     R15, R18
    LDI     R16, 0xB0           ; Código para dígito 3
    LDI     R17, 0x99           ; Código para dígito 4
    LDI     R18, 0x92           ; Código para dígito 5
    LDI     R19, 0x82           ; Código para dígito 6
    LDI     R20, 0xB8           ; Código para dígito 7
    LDI     R21, 0x80           ; Código para dígito 8
    LDI     R22, 0x98           ; Código para dígito 9
    LDI     R23, 0x88           ; Código para dígito A
    LDI     R24, 0x83           ; Código para dígito B
    LDI     R25, 0xC6           ; Código para dígito C
    LDI     R26, 0xA1           ; Código para dígito D
    LDI     R27, 0x86           ; Código para dígito E
    LDI     R28, 0x8E           ; Código para dígito F

;-------------------------------------------------------------------------------
; Bucle Principal - Muestra Secuencia 0-F
;-------------------------------------------------------------------------------
CICLO:
    ; Mostrar dígito 0
    OUT     PORTA, R13
    LDI     R31, 0x0A
CICLO3_0:
    LDI     R30, 0xFF
CICLO2_0:
    LDI     R29, 0xFF
CICLO1_0:
    DEC     R29
    BRNE    CICLO1_0
    DEC     R30
    BRNE    CICLO2_0
    DEC     R31
    BRNE    CICLO3_0

    ; Mostrar dígito 1
    OUT     PORTA, R14
    LDI     R31, 0x0A
CICLO3_1:
    LDI     R30, 0xFF
CICLO2_1:
    LDI     R29, 0xFF
CICLO1_1:
    DEC     R29
    BRNE    CICLO1_1
    DEC     R30
    BRNE    CICLO2_1
    DEC     R31
    BRNE    CICLO3_1

    ; Mostrar dígito 2
    OUT     PORTA, R15
    LDI     R31, 0x0A
CICLO3_2:
    LDI     R30, 0xFF
CICLO2_2:
    LDI     R29, 0xFF
CICLO1_2:
    DEC     R29
    BRNE    CICLO1_2
    DEC     R30
    BRNE    CICLO2_2
    DEC     R31
    BRNE    CICLO3_2

    ; Mostrar dígito 3
    OUT     PORTA, R16
    LDI     R31, 0x0A
CICLO3_3:
    LDI     R30, 0xFF
CICLO2_3:
    LDI     R29, 0xFF
CICLO1_3:
    DEC     R29
    BRNE    CICLO1_3
    DEC     R30
    BRNE    CICLO2_3
    DEC     R31
    BRNE    CICLO3_3

    ; Mostrar dígito 4
    OUT     PORTA, R17
    LDI     R31, 0x0A
CICLO3_4:
    LDI     R30, 0xFF
CICLO2_4:
    LDI     R29, 0xFF
CICLO1_4:
    DEC     R29
    BRNE    CICLO1_4
    DEC     R30
    BRNE    CICLO2_4
    DEC     R31
    BRNE    CICLO3_4

    ; Mostrar dígito 5
    OUT     PORTA, R18
    LDI     R31, 0x0A
CICLO3_5:
    LDI     R30, 0xFF
CICLO2_5:
    LDI     R29, 0xFF
CICLO1_5:
    DEC     R29
    BRNE    CICLO1_5
    DEC     R30
    BRNE    CICLO2_5
    DEC     R31
    BRNE    CICLO3_5

    ; Mostrar dígito 6
    OUT     PORTA, R19
    LDI     R31, 0x0A
CICLO3_6:
    LDI     R30, 0xFF
CICLO2_6:
    LDI     R29, 0xFF
CICLO1_6:
    DEC     R29
    BRNE    CICLO1_6
    DEC     R30
    BRNE    CICLO2_6
    DEC     R31
    BRNE    CICLO3_6

    ; Mostrar dígito 7
    OUT     PORTA, R20
    LDI     R31, 0x0A
CICLO3_7:
    LDI     R30, 0xFF
CICLO2_7:
    LDI     R29, 0xFF
CICLO1_7:
    DEC     R29
    BRNE    CICLO1_7
    DEC     R30
    BRNE    CICLO2_7
    DEC     R31
    BRNE    CICLO3_7

    ; Mostrar dígito 8
    OUT     PORTA, R21
    LDI     R31, 0x0A
CICLO3_8:
    LDI     R30, 0xFF
CICLO2_8:
    LDI     R29, 0xFF
CICLO1_8:
    DEC     R29
    BRNE    CICLO1_8
    DEC     R30
    BRNE    CICLO2_8
    DEC     R31
    BRNE    CICLO3_8

    ; Mostrar dígito 9
    OUT     PORTA, R22
    LDI     R31, 0x0A
CICLO3_9:
    LDI     R30, 0xFF
CICLO2_9:
    LDI     R29, 0xFF
CICLO1_9:
    DEC     R29
    BRNE    CICLO1_9
    DEC     R30
    BRNE    CICLO2_9
    DEC     R31
    BRNE    CICLO3_9

    ; Mostrar dígito A
    OUT     PORTA, R23
    LDI     R31, 0x0A
CICLO3_A:
    LDI     R30, 0xFF
CICLO2_A:
    LDI     R29, 0xFF
CICLO1_A:
    DEC     R29
    BRNE    CICLO1_A
    DEC     R30
    BRNE    CICLO2_A
    DEC     R31
    BRNE    CICLO3_A

    ; Mostrar dígito B
    OUT     PORTA, R24
    LDI     R31, 0x0A
CICLO3_B:
    LDI     R30, 0xFF
CICLO2_B:
    LDI     R29, 0xFF
CICLO1_B:
    DEC     R29
    BRNE    CICLO1_B
    DEC     R30
    BRNE    CICLO2_B
    DEC     R31
    BRNE    CICLO3_B

    ; Mostrar dígito C
    OUT     PORTA, R25
    LDI     R31, 0x0A
CICLO3_C:
    LDI     R30, 0xFF
CICLO2_C:
    LDI     R29, 0xFF
CICLO1_C:
    DEC     R29
    BRNE    CICLO1_C
    DEC     R30
    BRNE    CICLO2_C
    DEC     R31
    BRNE    CICLO3_C

    ; Mostrar dígito D
    OUT     PORTA, R26
    LDI     R31, 0x0A
CICLO3_D:
    LDI     R30, 0xFF
CICLO2_D:
    LDI     R29, 0xFF
CICLO1_D:
    DEC     R29
    BRNE    CICLO1_D
    DEC     R30
    BRNE    CICLO2_D
    DEC     R31
    BRNE    CICLO3_D

    ; Mostrar dígito E
    OUT     PORTA, R27
    LDI     R31, 0x0A
CICLO3_E:
    LDI     R30, 0xFF
CICLO2_E:
    LDI     R29, 0xFF
CICLO1_E:
    DEC     R29
    BRNE    CICLO1_E
    DEC     R30
    BRNE    CICLO2_E
    DEC     R31
    BRNE    CICLO3_E

    ; Mostrar dígito F
    OUT     PORTA, R28
    LDI     R31, 0x0A
CICLO3_F:
    LDI     R30, 0xFF
CICLO2_F:
    LDI     R29, 0xFF
CICLO1_F:
    DEC     R29
    BRNE    CICLO1_F
    DEC     R30
    BRNE    CICLO2_F
    DEC     R31
    BRNE    CICLO3_F

    RJMP    CICLO               ; Repetir secuencia infinitamente