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