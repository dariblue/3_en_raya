piececita:
    ; Pintar ficha en fila=2, col=2 usando atributo que deja coord_Atrib (lee D para color)
    LD B, 2
    LD C, 2

    CALL coord_Atrib   ; HL -> addr atributo (coord_Atrib preserva AF), D tiene color
    LD (HL), A
    INC HL
    LD (HL), A
    INC HL
    LD (HL), A

    ; atributos en la fila inferior de la celda (fila+1)
    ;INC B
    ;CALL Coord_Atrib
    LD E, 30
    LD D, 0
    add HL, DE
    LD (HL), A
    INC HL
    LD (HL), A
    INC HL
    LD (HL), A
    RET