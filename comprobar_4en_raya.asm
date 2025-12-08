; ==============================================================================
; Rutina: comprobar_ganapuerta
; Entrada: IX = Puntero a la última ficha colocada
; Salida:  A = 1 (Victoria), A = 0 (Sigue jugando)
; Datos del programa: C ->  Contiene el numero de fichas adyacentes para 
;                           comprobar si ha ganado
; ==============================================================================

comprobar_ganapuerta:
    PUSH BC : PUSH DE : PUSH HL
    
    ; 1. Obtener ID del jugador (1 o 2) de la casilla actual
    LD A, (IX+0)
    LD B, A             ; B = ID Jugador a buscar

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
    ; 5. Nadie ha ganado; si llegamos aqui es que no hay ningun patron ganador
    ; ==========================================================================
    POP HL : POP DE : POP BC
    LD A, 0             ; Retornar 0 (Sigue jugando)
    RET

ganapuerta:
    POP HL : POP DE : POP BC
    LD A, 1             ; Retornar 1 (Victoria)
    CALL fin

; ==============================================================================
; Subrutina: ContarDireccion
; Cuenta fichas consecutivas iguales al jugador (B) en una dirección (DE)
; Entrada: IX (Inicio), DE (Salto), B (ID Jugador)
; Salida:  A (Número de fichas encontradas en esa dirección)
; Nota:    Preserva IX original.
; ==============================================================================
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