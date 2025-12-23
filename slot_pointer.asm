; ==============================================================================
; Rutina: slot_Pointer
; Entrada: L (Columna lógica)
; Salida: IX (Puntero al inicio de la columna en memoria)
; Datos del programa: Fichas, TamColumna
; ==============================================================================

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