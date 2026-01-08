comprobar_ganapuerta:
    PUSH BC : PUSH DE : PUSH HL
    ; Obtener ID del jugador (1 o 2) de la casilla actual
    LD A, (IX+0)
    LD B, A 

    ; ==========================================================================
    ; 1. VERTICAL (Solo hacia abajo, +1)
    ; ==========================================================================
    LD C, 1             ; Contador Total (Empieza en 1)

    ; Mirar ABAJO (+1)
    LD DE, 1
    CALL contador_Ganapuerta
    ADD A, C            ; A = 1 + Abajo
    
    CP 4
    JR NC, ganapuerta

    ; ==========================================================================
    ; 2. HORIZONTAL (Eje +/- 8 bytes)
    ; ==========================================================================
    LD C, 1             ; Contador Total (Empieza en 1 por la ficha actual)

    ; Mirar a la DERECHA (+8)
    LD DE, 8
    CALL contador_Ganapuerta
    ADD A, C
    LD C, A             ; C = 1 + Derecha

    ; Mirar a la IZQUIERDA (-8)
    LD DE, -8
    CALL contador_Ganapuerta
    ADD A, C            ; A = Total Horizontal

    CP 4                ; ¿Hay 4 o más?
    JR NC, ganapuerta    ; Si A >= 4, Ganamos

    ; ==========================================================================
    ; 3. DIAGONAL BAJADA \ ABAJO-DERECHA (+9) ARRIBA-IZQUIERDA (-9)
    ; ==========================================================================
    LD C, 1             ; Reset Contador

    ; Mirar ABAJO-DERECHA (+9) -> (+8 Columna, +1 Fila)
    LD DE, 9
    CALL contador_Ganapuerta
    ADD A, C
    LD C, A

    ; Mirar ARRIBA-IZQUIERDA (-9) -> (-8 Columna, -1 Fila)
    LD DE, -9
    CALL contador_Ganapuerta
    ADD A, C

    CP 4
    JR NC, ganapuerta

    ; ==========================================================================
    ; 4. DIAGONAL SUBIDA / ARRIBA-DERECHA (+7) ABAJO-IZQUIERDA (-7)
    ; ==========================================================================
    LD C, 1             ; Reset Contador

    ; Mirar ARRIBA-DERECHA (+7) -> (+8 Columna, -1 Fila)
    LD DE, 7
    CALL contador_Ganapuerta
    ADD A, C
    LD C, A

    ; Mirar ABAJO-IZQUIERDA (-7) -> (-8 Columna, +1 Fila)
    LD DE, -7
    CALL contador_Ganapuerta
    ADD A, C

    CP 4
    JR NC, ganapuerta

    ; ==========================================================================
    ; 5. Nadie ha ganado; 
    ; ==========================================================================
    POP HL : POP DE : POP BC
    LD A, 0             ; Retornar 0 (Sigue jugando)
    RET


ganapuerta:
    POP HL : POP DE : POP BC

    ; Calcular color ganadora
    LD A, (color_jugador)
    CP COLOR_JUGADOR_1  ; Si es Rojo ($10), el ganador fue Amarillo (porque ya cambió el turno)
    JR Z, gano_amarillo
    
    ; Gano Rojo
    LD A, $0A           ; Ink Rojo (2), Paper Azul (1<<3=8) -> $0A
    JR guardar_ganadora

gano_amarillo:
    LD A, $0E           ; Ink Amarillo (6), Paper Azul (1<<3=8) -> $0E

guardar_ganadora:
    LD (ganadora), A

    LD A, 1             ; Retornar 1 (Victoria)
    RET                 ; Volver a conecta4_juego.asm para gestionar la victoria allí


;CONTADORES
contador_Ganapuerta:
    PUSH IX             ; Guardamos el puntero original (centro)
    PUSH BC             ; Guardamos B (ID) y C (Contador principal)
    
    LD C, 0             ; Contador local de esta dirección

bucle_Contador:
    ADD IX, DE          ; Avanzar en la dirección (IX = IX + DE)
    
    LD A, (IX+0)        ; Leer casilla
    CP B                ; ¿Es igual al jugador?
    JR NZ, fin_Contador         ; Si no es igual (o es borde $FF), terminamos
    
    INC C               ; Si es igual, incrementamos contador
    JR bucle_Contador           ; Seguimos buscando

fin_Contador:
    LD A, C             ; Pasamos el resultado a A
    POP BC              ; Recuperamos B y C originales
    POP IX              ; Recuperamos IX original
    RET