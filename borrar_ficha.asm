borrar_ficha:
    PUSH DE
    LD D, 0             ; Color 0 para borrar
    CALL dibujar_ficha  ; Usamos dibujar_ficha directamente
    POP DE
    RET

; Borra la ficha en la posición actual del jugador (fila 2)
borrar_ficha_actual:
    PUSH HL
    PUSH AF
    
    LD A, (ficha_columna)   ; Obtenemos la columna lógica
    
    ; Conversión de columna lógica a visual (x4 + offset)
    ADD A, A
    ADD A, A
    ADD A, COLUMNA_INICIAL
    
    LD L, A                 ; L = Coordenada X visual
    LD H, 2                 ; H = Fila superior (preview)
    
    CALL borrar_ficha       ; Llamamos a la rutina base
    
    POP AF
    POP HL
    RET