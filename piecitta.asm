; ==============================================================================
; Rutina: dibujar_ficha
; Entrada: H (Fila), L (Columna), D (Atributo de color)
; Salida: Pinta un bloque de 2x3 con el atributo especificado
; Datos del programa: Ninguno
; ==============================================================================
dibujar_ficha:
    PUSH BC
    PUSH DE
    PUSH HL

    LD B, 2             ; Altura de la ficha = 2 filas

bucle_alto:
    PUSH HL             ; Guardamos la coordenada de inicio de la fila actual
    PUSH BC             ; Guardamos el contador de altura

    LD B, 3             ; Anchura de la ficha = 3 columnas

bucle_ancho:
    PUSH HL             ; Guardamos las coordenadas (H,L) antes de que coord_Atrib las machaque
    PUSH BC             ; Guardamos el contador de anchura

    CALL coord_Atrib    ; Calcula dirección de atributos en HL
    LD (HL), D          ; Pinta el atributo

    POP BC              ; Recuperamos contador ancho
    POP HL              ; Recuperamos coordenadas (H,L)

    INC L               ; Siguiente columna a la derecha
    DJNZ bucle_ancho    ; Repetimos 3 veces

    POP BC              ; Recuperamos contador altura
    POP HL              ; Recuperamos el inicio de la fila

    INC H               ; Bajamos a la siguiente fila
    DJNZ bucle_alto     ; Repetimos 2 veces

    POP HL
    POP DE
    POP BC
    RET