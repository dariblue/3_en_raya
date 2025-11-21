; Rutina que recibe en B,C las coordenadas de la pantalla (fila, columna)
coord_Atrib:
    PUSH AF
    LD A, H
    SLA A: SLA A: SLA A: SLA A   ; A = fila * 16
    OR L
    LD L, A
    LD H, A
    SRA A: SRA A: SRA A  ; A = fila * 4
    OR $58
    LD H, A 
    POP AF
    RET
