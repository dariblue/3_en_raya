limpiar_memoria_jueguitto:
    ; Reset color
    LD A, COLOR_JUGADOR_1
    LD (color_jugador), A
    
    ; Reset Fichas array
    ; Tenemos 7 columnas. Cada una tiene 8 bytes.
    ; Estructura: $FF, 0, 0, 0, 0, 0, 0, $FF
    ; Debemos limpiar los bytes 1-6 de cada columna.
    
    LD HL, fichas
    LD B, 7         ; 7 columnas
.loop_cols:
    PUSH BC
    INC HL          ; Saltar índice 0 ($FF - Techo/Marcador)
    
    LD B, 6         ; 6 celdas a limpiar
    XOR A           ; A = 0
.loop_cells:
    LD (HL), A      ; Poner a 0
    INC HL
    DJNZ .loop_cells
    
    INC HL          ; Saltar índice 7 ($FF - Suelo)
    
    POP BC
    DJNZ .loop_cols
    RET