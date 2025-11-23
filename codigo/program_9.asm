;===============================================================================
; Programa: Multiplexado de 4 Displays de 7 Segmentos
; Microcontrolador: ATmega8515
; Descripción: Muestra la palabra "CArS" en 4 displays de 7 segmentos usando
;              técnica de multiplexado temporal
; Autor: Equipo 1
;===============================================================================

.INCLUDE "m8515def.inc"

;-------------------------------------------------------------------------------
; Configuración de Puertos
;-------------------------------------------------------------------------------
INICIO:
    LDI     R16, 0xFF           ; Cargar 0xFF en R16
    OUT     DDRA, R16           ; Configurar Puerto A como salida (segmentos)

    LDI     R16, 0xFF           ; Cargar 0xFF en R16
    OUT     DDRB, R16           ; Configurar Puerto B como salida (control)

;-------------------------------------------------------------------------------
; Inicialización del Stack Pointer
;-------------------------------------------------------------------------------
    LDI     R16, LOW(RAMEND)    ; Cargar byte bajo de RAMEND
    OUT     SPL, R16            ; Configurar Stack Pointer Low
    LDI     R16, HIGH(RAMEND)   ; Cargar byte alto de RAMEND
    OUT     SPH, R16            ; Configurar Stack Pointer High

;-------------------------------------------------------------------------------
; Programa Principal
; Descripción: Ciclo infinito de multiplexado que muestra cada carácter
;              secuencialmente en su display correspondiente
;-------------------------------------------------------------------------------
CICLO:
    ; Mostrar letra C en Display 1
    LDI     R22, 0xC6           ; Código para letra 'C'
    RCALL   MOSTRAR_0           ; Activar Display 1

    ; Mostrar letra A en Display 2
    LDI     R22, 0x88           ; Código para letra 'A'
    RCALL   MOSTRAR_1           ; Activar Display 2

    ; Mostrar letra r en Display 3
    LDI     R22, 0xAF           ; Código para letra 'r'
    RCALL   MOSTRAR_2           ; Activar Display 3

    ; Mostrar letra S en Display 4
    LDI     R22, 0x92           ; Código para letra 'S'
    RCALL   MOSTRAR_3           ; Activar Display 4

    RJMP    CICLO               ; Repetir ciclo de multiplexado

;-------------------------------------------------------------------------------
; Subrutinas de Multiplexado
; Descripción: Cada subrutina activa un display específico mostrando el
;              carácter contenido en R22
;-------------------------------------------------------------------------------

MOSTRAR_0:
    OUT     PORTA, R22          ; Enviar código de segmentos al Puerto A
    LDI     R23, 0xFF           ; Cargar 0xFF para apagar todos
    OUT     PORTB, R23          ; Apagar todos los displays
    LDI     R23, 0xFE           ; Activar solo Display 1 (bit 0 = 0)
    OUT     PORTB, R23          ; Aplicar máscara de control
    RCALL   RETARDO             ; Mantener display activo
    RET                         ; Retornar de subrutina

MOSTRAR_1:
    OUT     PORTA, R22          ; Enviar código de segmentos al Puerto A
    LDI     R23, 0xFF           ; Cargar 0xFF para apagar todos
    OUT     PORTB, R23          ; Apagar todos los displays
    LDI     R23, 0xFD           ; Activar solo Display 2 (bit 1 = 0)
    OUT     PORTB, R23          ; Aplicar máscara de control
    RCALL   RETARDO             ; Mantener display activo
    RET                         ; Retornar de subrutina

MOSTRAR_2:
    OUT     PORTA, R22          ; Enviar código de segmentos al Puerto A
    LDI     R23, 0xFF           ; Cargar 0xFF para apagar todos
    OUT     PORTB, R23          ; Apagar todos los displays
    LDI     R23, 0xFB           ; Activar solo Display 3 (bit 2 = 0)
    OUT     PORTB, R23          ; Aplicar máscara de control
    RCALL   RETARDO             ; Mantener display activo
    RET                         ; Retornar de subrutina

MOSTRAR_3:
    OUT     PORTA, R22          ; Enviar código de segmentos al Puerto A
    LDI     R23, 0xFF           ; Cargar 0xFF para apagar todos
    OUT     PORTB, R23          ; Apagar todos los displays
    LDI     R23, 0xF7           ; Activar solo Display 4 (bit 3 = 0)
    OUT     PORTB, R23          ; Aplicar máscara de control
    RCALL   RETARDO             ; Mantener display activo
    RET                         ; Retornar de subrutina

;-------------------------------------------------------------------------------
; Subrutina: Retardo para Multiplexado
; Descripción: Genera un retardo breve para mantener el display visible
;              sin parpadeo perceptible
; Registros usados: R24, R25, R26
;-------------------------------------------------------------------------------
RETARDO:
    LDI     R24, 1              ; Inicializar contador externo
    LDI     R25, 120            ; Inicializar contador medio
    LDI     R26, 225            ; Inicializar contador interno
L1:
    DEC     R26                 ; Decrementar contador interno
    BRNE    L1                  ; Repetir si no es cero
    DEC     R25                 ; Decrementar contador medio
    BRNE    L1                  ; Repetir si no es cero
    DEC     R24                 ; Decrementar contador externo
    BRNE    L1                  ; Repetir si no es cero
    RET                         ; Retornar de subrutina