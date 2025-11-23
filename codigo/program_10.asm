;===============================================================================
; Programa: Lectura de Teclado Matricial 4x4
; Microcontrolador: ATmega8515
; Descripción: Lee un teclado matricial y muestra el dígito presionado en
;              un display de 7 segmentos conectado al Puerto A
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
    ; Puerto A: Salida para display de 7 segmentos
    LDI     R16, 0xFF           ; Cargar 0xFF en R16
    OUT     DDRA, R16           ; Configurar Puerto A como salida

    ; Puerto C: Nibble alto (PC7-PC4) salida, nibble bajo (PC3-PC0) entrada
    LDI     R16, 0xF0           ; Configurar PC7-PC4 como salida (filas)
    OUT     DDRC, R16           ; PC3-PC0 como entrada (columnas)

    ; Configurar estados iniciales
    LDI     R16, 0xFF           ; Cargar 0xFF en R16
    OUT     PORTC, R16          ; Filas en alto, pull-ups activos en columnas

    ; Inicializar display con valor neutro
    LDI     R19, 0xFF           ; Cargar 0xFF (display apagado)
    OUT     PORTA, R19          ; Mostrar en display

;-------------------------------------------------------------------------------
; Programa Principal - Escaneo del Teclado
; Descripción: Escanea continuamente el teclado matricial buscando teclas
;              presionadas mediante barrido de filas
;-------------------------------------------------------------------------------
CICLO:
    LDI     R17, 0xFF           ; Inicializar offset de tabla (contador)

;-------------------------------------------------------------------------------
; Escaneo de Fila 1
;-------------------------------------------------------------------------------
F1:
    CBI     PORTC, 7            ; Activar fila 1 (PC7 = 0)

    ; Verificar columna 1
F1_C1:
    INC     R17                 ; Incrementar offset de tabla
    RCALL   REBOTE              ; Retardo anti-rebote de 20ms
    IN      R18, PINC           ; Leer estado del Puerto C
    BST     R18, 3              ; Copiar bit 3 (columna 1) a flag T
    SBI     PORTC, 7            ; Desactivar fila 1 (PC7 = 1)
    BRTS    F1_C2               ; Si T=1, tecla no presionada, siguiente columna
    RCALL   DATO_TABLA          ; Si T=0, obtener y mostrar dato
    RJMP    CICLO               ; Reiniciar escaneo

    ; Verificar columna 2
F1_C2:
    INC     R17                 ; Incrementar offset de tabla
    CBI     PORTC, 7            ; Activar fila 1 (PC7 = 0)
    RCALL   REBOTE              ; Retardo anti-rebote de 20ms
    IN      R18, PINC           ; Leer estado del Puerto C
    BST     R18, 2              ; Copiar bit 2 (columna 2) a flag T
    SBI     PORTC, 7            ; Desactivar fila 1 (PC7 = 1)
    BRTS    F1_C3               ; Si T=1, tecla no presionada, siguiente columna
    RCALL   DATO_TABLA          ; Si T=0, obtener y mostrar dato
    RJMP    CICLO               ; Reiniciar escaneo

    ; Verificar columna 3
F1_C3:
    INC     R17                 ; Incrementar offset de tabla
    CBI     PORTC, 7            ; Activar fila 1 (PC7 = 0)
    RCALL   REBOTE              ; Retardo anti-rebote de 20ms
    IN      R18, PINC           ; Leer estado del Puerto C
    BST     R18, 1              ; Copiar bit 1 (columna 3) a flag T
    SBI     PORTC, 7            ; Desactivar fila 1 (PC7 = 1)
    BRTS    F1_C4               ; Si T=1, tecla no presionada, siguiente columna
    RCALL   DATO_TABLA          ; Si T=0, obtener y mostrar dato
    RJMP    CICLO               ; Reiniciar escaneo

    ; Verificar columna 4
F1_C4:
    INC     R17                 ; Incrementar offset de tabla
    CBI     PORTC, 7            ; Activar fila 1 (PC7 = 0)
    RCALL   REBOTE              ; Retardo anti-rebote de 20ms
    IN      R18, PINC           ; Leer estado del Puerto C
    BST     R18, 0              ; Copiar bit 0 (columna 4) a flag T
    SBI     PORTC, 7            ; Desactivar fila 1 (PC7 = 1)
    BRTS    FIN                 ; Si T=1, tecla no presionada, finalizar
    RCALL   DATO_TABLA          ; Si T=0, obtener y mostrar dato
    RJMP    CICLO               ; Reiniciar escaneo

FIN:
    RJMP    CICLO               ; Reiniciar escaneo del teclado

;-------------------------------------------------------------------------------
; Subrutina: Obtener Dato de Tabla
; Descripción: Calcula la posición en la tabla según el offset en R17,
;              lee el código correspondiente y lo muestra en el display
; Registros usados: R17 (entrada), R19 (salida), R30, R31
;-------------------------------------------------------------------------------
DATO_TABLA:
    ; Calcular dirección en tabla
    LDI     R31, HIGH(TABLA << 1)   ; Cargar byte alto de dirección de tabla
    LDI     R30, LOW(TABLA << 1)    ; Cargar byte bajo de dirección de tabla
    ADD     R30, R17                ; Sumar offset a dirección base
    BRCC    SIGUE                   ; Si no hay carry, continuar
    INC     R31                     ; Si hay carry, incrementar byte alto

SIGUE:
    LPM     R19, Z              ; Leer código desde tabla
    OUT     PORTA, R19          ; Mostrar en display
    RET                         ; Retornar de subrutina

;-------------------------------------------------------------------------------
; Subrutina: Retardo Anti-Rebote
; Descripción: Genera un retardo de 20ms para eliminar rebotes mecánicos
;              del teclado
; Ciclos: 160,000 ciclos a 8.0 MHz = 20ms
; Registros usados: R20, R21
;-------------------------------------------------------------------------------
REBOTE:
    LDI     R20, 8              ; Inicializar contador externo
    LDI     R21, 202            ; Inicializar contador interno
L1:
    DEC     R21                 ; Decrementar contador interno
    BRNE    L1                  ; Repetir si no es cero
    DEC     R20                 ; Decrementar contador externo
    BRNE    L1                  ; Repetir si no es cero
    NOP                         ; Ajuste fino de tiempo
    RET                         ; Retornar de subrutina

;-------------------------------------------------------------------------------
; Tabla de Códigos para Display 7 Segmentos
; Descripción: Códigos para representar dígitos hexadecimales 0-F
;              con lógica inversa (ánodo común)
;-------------------------------------------------------------------------------
TABLA:
    .DB 0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8
    .DB 0x80, 0x98, 0x88, 0x83, 0xC6, 0xA1, 0x86, 0x8E