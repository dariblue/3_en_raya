; Rutina de juego
juego:
    CALL drawBoard
    CALL gameLoop         ; Entrar en el bucle principal del juego
    RET

; Dibuja el tablero inicial (tablerito.scr) y la ficha del jugador activo
drawBoard:
    LD HL, tablerito 
    LD DE, $4000  ; Dirección de pantalla en ZX Spectrum
    LD BC, $5B00 - $4000    ; tamaño: $5B00 - $4000 = $1B00 (6912 bytes) tamaño pantalla ZX Spectrum
    LDIR 
    
    ; Pintar ficha inicial del jugador activo encima de la primera columna
    ; Coordenadas: Fila 2, Columna inicial (Ajustado para pegar al tablero)
    LD H, 2                 ; Fila 2
    LD L, COLUMNA_INICIAL   ; Columna inicial
    
    ; Guardar la posición inicial
    LD A, H
    LD (ficha_fila), A
    LD A, L
    LD (ficha_columna), A
    
    LD D, COLOR_JUGADOR_1   ; Color del jugador 1 (rojo)
    CALL dibujar_ficha
    RET
    
    ; TODO: Modificar para que el color venga en D

; Bucle principal: espera tecla, cambia jugador y repinta la ficha
gameLoop:
    CALL tecladoQW_INT_F  ; Leer tecla pulsada (Devuelve en A: 'Q', 'W', 'E', 'F')
    
    ; Verificar qué tecla se pulsó
    CP 'W'
    JP Z, mover_dcha      ; Si es W, mover a la derecha (JP para evitar error de rango)
    
    CP 'Q'
    JP Z, mover_izq       ; Si es Q, mover a la izquierda
    
    CP 'E'                ; Enter
    JP Z, cambiar_jugador_y_soltar
    
    CP 'F'                ; F para finalizar
    JP Z, fin_juego
    
    JP gameLoop           ; Continuar el bucle

cambiar_jugador_y_soltar:
    ; TODO: Implementar lógica de soltar ficha y cambiar jugador
    JP gameLoop

mover_dcha:
    ; 1. Cargar posición actual
    LD A, (ficha_fila)
    LD H, A
    LD A, (ficha_columna)
    LD L, A
    
    ; 2. Verificar límite derecho
    LD A, L
    CP COLUMNA_MAXIMA   ; ¿Estamos en la última columna?
    JP Z, gameLoop      ; Si sí, volver sin hacer nada
    
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
    
    JP gameLoop

mover_izq:
    ; 1. Cargar posición actual
    LD A, (ficha_fila)
    LD H, A
    LD A, (ficha_columna)
    LD L, A
    
    ; 2. Verificar límite izquierdo
    LD A, L
    CP COLUMNA_INICIAL  ; ¿Estamos en la primera columna?
    JP Z, gameLoop      ; Si sí, volver sin hacer nada
    
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
    
    JP gameLoop

borrar_ficha:
    LD D, 0             ; Color 0 (Negro/Borrar)
    CALL dibujar_ficha
    RET

fin_juego:
    CALL CLEARSCR   ; Borrar pantalla
    CALL despedida
    ;TODO Pintar bien la piececita segun el jugador activo (color en D)

; Constantes para el tablero
COLUMNA_INICIAL     EQU 2       ; Primera columna del tablero
COLUMNA_INCREMENTO  EQU 4       ; Incremento entre columnas (3 de ficha + 1 de borde)
COLUMNA_MAXIMA      EQU COLUMNA_INICIAL + (6 * COLUMNA_INCREMENTO)  ; Última columna (7 columnas: 0-6)

; Constantes de color
COLOR_JUGADOR_1     EQU $10     ; Color rojo para jugador 1
COLOR_JUGADOR_2     EQU $30     ; Color amarillo para jugador 2
COLOR_FONDO         EQU $07     ; Color de fondo del tablero (blanco sobre negro)

; Variables para la posición de la ficha
ficha_fila:    DB 0
ficha_columna: DB 0

; Etiqueta del recurso binario del tablero (archivo .scr)
tablerito: INCBIN "tablerito.scr"



