; ==============================================================================
; Rutina: mover_dcha
; Entrada: ficha_columna, ficha_fila
; Salida: Mueve la ficha visualmente a la derecha si es posible
; Datos del programa: COLUMNA_MAXIMA, COLUMNA_INCREMENTO
; ==============================================================================

mover_dcha:
    ; 1. Cargar posición actual
    LD A, (ficha_fila)
    LD H, A
    LD A, (ficha_columna)
    LD L, A
    
    ; 2. Verificar límite derecho
    LD A, L
    CP COLUMNA_MAXIMA   ; ¿Estamos en la última columna?
    RET Z      ; Si sí, volver sin hacer nada
    
    ; 3. BORRAR ficha actual (Pintar de negro)
    CALL borrar_ficha
    
    ; 4. Calcular nueva posición
    LD A, (ficha_columna)
    ADD A, COLUMNA_INCREMENTO
    LD (ficha_columna), A   ; Guardar nueva columna
    LD L, A                 ; Actualizar L para pintar
    
    ; 5. PINTAR ficha nueva (Color del jugador)
    LD H, 2                 ; Fila siempre 2
    LD D, COLOR_JUGADOR_1   ; TODO: Usar variable de jugador activo
    CALL dibujar_ficha
    
    RET