; ==============================================================================
; Rutina: mover_izq
; Entrada: ficha_columna, ficha_fila
; Salida: Mueve la ficha visualmente a la izquierda si es posible
; Datos del programa: COLUMNA_INICIAL, COLUMNA_INCREMENTO
; ==============================================================================

mover_izq:
    ; 1. Cargar posición actual
    LD A, (ficha_fila)
    LD H, A
    LD A, (ficha_columna)
    LD L, A
    
    ; 2. Verificar límite izquierdo
    LD A, L
    CP COLUMNA_INICIAL  ; ¿Estamos en la primera columna?
    RET Z      ; Si sí, volver sin hacer nada
    
    ; 3. BORRAR ficha actual
    CALL borrar_ficha
    
    ; 4. Calcular nueva posición
    LD A, (ficha_columna)
    SUB COLUMNA_INCREMENTO
    LD (ficha_columna), A   ; Guardar nueva columna
    LD L, A                 ; Actualizar L para pintar
    
    ; 5. PINTAR ficha nueva
    LD H, 2
    LD D, COLOR_JUGADOR_1
    CALL dibujar_ficha
    
    RET
