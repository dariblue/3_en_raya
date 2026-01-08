pintar_ficha:
    PUSH HL
    PUSH DE
    LD A, L
    ADD A, A
    ADD A, A
    ADD A, COLUMNA_INICIAL
    LD L, A
    LD H, 2
    LD A, (color_jugador)
    LD D, A
    CALL dibujar_ficha
    POP DE
    POP HL
    RET

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