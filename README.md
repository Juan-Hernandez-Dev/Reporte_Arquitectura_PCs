# Prácticas de Programación en Ensamblador - ATmega8515

## Propósito del Repositorio

Este repositorio contiene una colección de 10 prácticas de programación en lenguaje ensamblador para el microcontrolador ATmega8515. El objetivo es proporcionar ejemplos prácticos y progresivos que cubren desde conceptos básicos de entrada/salida hasta técnicas avanzadas como interrupciones, multiplexado y manejo de periféricos.

Estas prácticas están diseñadas para estudiantes y desarrolladores que desean aprender programación de microcontroladores a bajo nivel, comprendiendo el funcionamiento interno del hardware y las técnicas fundamentales de sistemas embebidos.

## Estructura del Repositorio

```
├── codigo/          # Archivos .asm con el código fuente de cada práctica
├── texto/           # Archivos .txt con explicaciones detalladas de cada práctica
└── README.md        # Este archivo
```

---

## Resumen de las Prácticas

### Práctica 1: Lectura de Puerto B y Escritura en Puerto A

**Conceptos:** Configuración de puertos, entrada/salida digital, resistencias pull-up

Programa básico que lee continuamente datos del Puerto B y los refleja en el Puerto A. Introduce la configuración de puertos como entrada/salida y el uso de resistencias pull-up internas.

---

### Práctica 2: Desplazamiento de Bit en Puerto A

**Conceptos:** Manipulación de bits, retardos, bucles

Implementa un efecto visual de desplazamiento de un bit activo a través de los 8 bits del Puerto A, creando un patrón de luz secuencial de derecha a izquierda.

---

### Práctica 3: Contador Hexadecimal en Display 7 Segmentos

**Conceptos:** Display 7 segmentos, codificación de caracteres, lógica inversa

Muestra una secuencia de dígitos hexadecimales (0-F) en un display de 7 segmentos con lógica inversa (ánodo común), enseñando la codificación de caracteres para displays.

---

### Práctica 4: Desplazamiento Bidireccional de Bit

**Conceptos:** Operaciones de desplazamiento (LSL/LSR), subrutinas, Stack Pointer

Implementa un desplazamiento de bit que cambia de dirección automáticamente, creando un efecto de "rebote" visual. Introduce el uso de subrutinas y configuración del Stack Pointer.

---

### Práctica 5: Demostración de Operaciones con Stack

**Conceptos:** Stack (pila), PUSH/POP, principio LIFO

Demuestra el funcionamiento del stack y las operaciones PUSH y POP para almacenar y recuperar datos temporalmente, fundamental para el manejo de subrutinas e interrupciones.

---

### Práctica 6: Contador 0-9 y A-Z en Display 7 Segmentos

**Conceptos:** Tablas en memoria de programa, instrucción LPM, manejo de direcciones

Utiliza tablas almacenadas en memoria de programa para mostrar una secuencia extendida de 36 caracteres (0-9, A-Z) en un display de 7 segmentos.

---

### Práctica 7: Manejo de Interrupción Externa INT0

**Conceptos:** Interrupciones externas, vectores de interrupción, ISR, preservación de contexto

Implementa un sistema de interrupciones que cambia el comportamiento del programa cuando se detecta un flanco descendente en INT0. El programa principal cuenta 0-9, pero al interrumpirse muestra letras A-F.

---

### Práctica 8: Contador Decimal 0-99

**Conceptos:** Contadores de múltiples dígitos, lógica decimal, displays múltiples

Implementa un contador de dos dígitos (0-99) que muestra unidades y decenas en displays separados, manejando el desbordamiento decimal correctamente.

---

### Práctica 9: Multiplexado de 4 Displays de 7 Segmentos

**Conceptos:** Multiplexado temporal, persistencia visual, optimización de pines

Muestra la palabra "CArS" en 4 displays de 7 segmentos usando técnica de multiplexado temporal, reduciendo el número de pines necesarios y aprovechando la persistencia visual.

---

### Práctica 10: Lectura de Teclado Matricial 4x4

**Conceptos:** Teclado matricial, escaneo de filas/columnas, anti-rebote

Implementa un sistema de lectura de teclado matricial 4x4 que detecta qué tecla fue presionada y muestra el valor correspondiente en un display de 7 segmentos, incluyendo manejo de anti-rebote.

---

## Requisitos

- **Microcontrolador:** ATmega8515
- **Ensamblador:** AVR Assembler compatible
- **Archivo de definiciones:** m8515def.inc

## Uso

1. Navega a la carpeta `codigo/` para acceder al código fuente
2. Consulta la carpeta `texto/` para leer las explicaciones detalladas de cada práctica
3. Ensambla el archivo .asm correspondiente con tu herramienta de desarrollo AVR
4. Carga el programa en el microcontrolador ATmega8515

## Autor

Equipo 1

## Notas

Cada práctica está documentada tanto en el código fuente (comentarios detallados) como en archivos de texto separados que explican el objetivo, los conceptos y las aplicaciones prácticas.