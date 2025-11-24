
;     LD IX, FICHAS
;     LD A, L
;     LD D, 0 : LD E,7
;     OR A

; bucle:
;     JR Z, B2
;     ADD IX, DE
;     DEC A
;     JR bucle

; b2:
;     CALL borrar_ficha
;     INC H
;     CALL Pintar_Ficha
;     CALL esperar
;     INC IX
;     LD A, (IX)
;     OR A
;     JR Z, b2
;     DEC IX
;     LD A, (JUGADOR)
;     LD (IX), A
;     RET
