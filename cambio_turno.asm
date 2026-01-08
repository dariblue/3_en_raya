cambio_turnitto:
    LD A, (color_jugador)
    CP COLOR_JUGADOR_1
    JR Z, .set_j2
    
    LD A, COLOR_JUGADOR_1
    LD (color_jugador), A
    JR .reset_pos

.set_j2:
    LD A, COLOR_JUGADOR_2
    LD (color_jugador), A

.reset_pos:
    LD A, 0
    LD (ficha_columna), A
    RET