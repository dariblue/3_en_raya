; ==============================================================================
; Rutina: coord_Atrib
; Entrada: H (Fila 0-23), L (Columna 0-31)
; Salida: HL (Dirección de memoria de atributos correspondiente)
; Datos del programa: Ninguno
; ==============================================================================
coord_Atrib:
    PUSH AF
    
    ; Calculo parte BAJA: L = (Fila * 32) + Columna
    LD A, H
        SLA A : SLA A : SLA A : SLA A : SLA A       ; A = Fila * 32 (5 desplazamientos)
    OR L        ; A = (Fila * 32) + Columna
    LD L, A     ; Guardamos parte baja en L
    
    ; Calculo parte ALTA: H = $58 + (Fila / 8)
    LD A, H     ; Recargamos A con la Fila original (IMPORTANTE)
    SRA A : SRA A : SRA A       ; A = Fila / 8
    OR $58      ; A = $58 + Offset tercio
    LD H, A     ; Guardamos parte alta en H
    
    POP AF
    RET
