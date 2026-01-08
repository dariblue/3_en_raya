bajar_ficha:
    LD A, (ficha_columna)  
    LD C, A              
    
    LD HL, fichas
    LD B, 0
    
    ADD A, A            ; x2
    ADD A, A            ; x4
    ADD A, A            ; x8
    LD C, A
    ADD HL, BC
    PUSH HL
    POP IX            
    
    ; Verificar si la columna está llena (Fila 0 ocupada)
    LD A, (IX+1)
    OR A
    RET NZ          ; Si no es 0, columna llena. Retornamos (Z=0)
    
    ; Si es 0, columna libre. Retornamos (Z=1)
    CP A
    RET


preparar_coordenadas_caida:
    LD A, (ficha_columna)
    ADD A, A
    ADD A, A
    ADD A, COLUMNA_INICIAL
    LD L, A
    LD H, 5
    RET

verificar_siguiente_casilla:
    LD A, (IX+1)
    OR A
    RET

avanzar_posicion:
    INC H
    INC H
    INC H               ; +3 filas visuales
    INC IX              ; +1 fila lógica
    RET

finalizar_turno_caida:
    LD A, (color_jugador)
    CP COLOR_JUGADOR_1
    JR NZ, .guardar_j2
    
    LD (IX+0), 1        ; Guardar 1 para Rojo
    RET

.guardar_j2:
    LD (IX+0), 2        ; Guardar 2 para Amarillo
    RET


