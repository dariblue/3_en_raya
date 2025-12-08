bajar_ficha:
    ; 1. Calcular puntero IX (Ahora es más fácil, ya tenemos la columna lógica)
    LD A, (ficha_columna)   ; A = 0.6
    LD C, A                 ; C = Columna
    
    LD HL, Fichas
    LD B, 0
    ; BC = C * 7
    ADD A, A            ; x2
    ADD A, A            ; x4
    ADD A, A            ; x8
    LD C, A
    ADD HL, BC
    PUSH HL
    POP IX              ; IX apunta al inicio de columna (Fila 0)
    
    ; 2. Verificar si la columna está llena (Fila 0 ocupada)
    LD A, (IX+1)
    OR A
    JP NZ, jugar_ficha   ; Columna llena, volver a control

    ; 3. Primer paso: Caer de Preview (H=2) a Tablero (H=5)
    ; Borrar de arriba
    LD A, (ficha_columna)
    ; Calculo visual inline
    ADD A, A
    ADD A, A
    ADD A, COLUMNA_INICIAL
    LD L, A
    LD H, 2
    CALL borrar_ficha
    
    ; Pintar en primera casilla
    INC H
    INC H
    INC H               ; H=5
    LD A, (color_jugador)
    LD D, A
    CALL dibujar_ficha
    CALL pausa_breve
    INC IX

bucle_caida:
    ; Verificar siguiente casilla lógica (IX+1)
    LD A, (IX+1)
    OR A
    JR NZ, colision     ; Si no es 0 (Ficha o Suelo), paramos

    ; Bajar un paso
    CALL borrar_ficha
    INC H
    INC H
    INC H               ; +3 filas visuales
    INC IX              ; +1 fila lógica
    
    LD A, (color_jugador)
    LD D, A
    CALL dibujar_ficha
    CALL pausa_breve
    JR bucle_caida

colision:
    ; 5. Fijar ficha en memoria
    LD A, (color_jugador)
    CP COLOR_JUGADOR_1
    JR NZ, guardar_j2
    
    LD (IX+0), 1        ; Guardar 1 para Rojo
    CALL comprobar_ganapuerta
    CALL comprobar_tablas
    JR cambio_turno

guardar_j2:
    LD (IX+0), 2        ; Guardar 2 para Amarillo
    CALL comprobar_ganapuerta
    CALL comprobar_tablas

cambio_turno:
    LD A, (color_jugador)
    CP COLOR_JUGADOR_1
    JR Z, set_j2
    
    LD A, COLOR_JUGADOR_1
    LD (color_jugador), A
    JR reset_pos

set_j2:
    LD A, COLOR_JUGADOR_2
    LD (color_jugador), A

reset_pos:
    ; Resetear posición lógica al centro o inicio (opcional, o dejar donde estaba)
    ; El profe suele reiniciar en 0 o mantener. Reiniciamos a 0 para consistencia.
    LD A, 0
    LD (ficha_columna), A
    JP jugar_ficha

pausa_breve:
    PUSH BC
    LD B, 2
p_loop:
    PUSH BC
    LD BC, $1000
d_loop:
    DEC BC
    LD A, B
    OR C
    JR NZ, d_loop
    POP BC
    DJNZ p_loop
    POP BC
    RET
