slot_Pointer:
    LD IX, Fichas
    LD DE, TamColumna
    LD A, L
    OR JR Z, SP2

SP1: 
    ADD IX, DE
    DEC A
    JR NZ, SP1
    LD E, H 
    DEC E
    ADD IX, DE
    RET