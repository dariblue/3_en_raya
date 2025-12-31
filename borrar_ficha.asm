; ==============================================================================
; Rutina: borrar_ficha
; Entrada: HL (Coordenadas visuales)
; Salida: Pinta de negro (color 0) en la posición indicada
; Datos del programa: Ninguno
; ==============================================================================

borrar_ficha:
    PUSH DE
    LD D, 0             ; Color 0 para borrar
    CALL dibujar_ficha  ; Usamos dibujar_ficha directamente
    POP DE
    RET
    
; ==============================================================================
; Rutina: borrar_ficha_preview
; Entrada: L (Columna l�gica 0-6)
; Salida: Borra la ficha en la fila de preview (H=2)
; Preserva: AF, HL
; ==============================================================================
borrar_ficha_preview:
    PUSH AF
    PUSH HL
    
    LD A, L
    ADD A, A
    ADD A, A
    ADD A, COLUMNA_INICIAL
    LD L, A
    LD H, 2
    CALL borrar_ficha
    
    POP HL
    POP AF
    RET
