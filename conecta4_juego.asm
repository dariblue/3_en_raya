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
    CALL tecladoQW_INT_F  ; Leer tecla pulsada
    
    ; Verificar qué tecla se pulsó
    CP 'W'
    JR Z, mover_dcha      ; Si es W, mover a la derecha
    
    CP 'Q'
    JR Z, mover_izq       ; Si es Q, mover a la izquierda
    
    CP 'E'                ; Enter
    JR Z, cambiar_jugador_y_soltar
    
    CP 'F'                ; F para finalizar
    JR Z, fin_juego
    
    JP gameLoop           ; Continuar el bucle

cambiar_jugador_y_soltar:
    ; TODO: Implementar lógica de soltar ficha y cambiar jugador
    JP gameLoop

mover_dcha:
    ; Cargar posición actual
    LD A, (ficha_fila)
    LD H, A
    LD A, (ficha_columna)
    LD L, A
    
    ; Verificar si podemos mover a la derecha
    ; El tablero tiene 7 columnas, separadas por COLUMNA_INCREMENTO
    LD A, L
    CP COLUMNA_MAXIMA   ; Verificar si ya estamos en la columna más a la derecha
    JP Z, gameLoop      ; Si ya estamos al borde derecho, no mover
    
    ; Borrar la ficha en la posición actual
    CALL borrar_ficha
    
    ; Incrementar columna (pasar a la siguiente columna del tablero)
    LD A, L
    ADD A, COLUMNA_INCREMENTO
    LD L, A
    
    ; Guardar la nueva posición
    LD A, H
    LD (ficha_fila), A
    LD A, L
    LD (ficha_columna), A
    
    ; Dibujar la ficha en la nueva posición
    LD D, COLOR_JUGADOR_1   ; Color del jugador 1 (TODO: usar color del jugador activo)
    CALL dibujar_ficha
    
    JP gameLoop

mover_izq:
    ; TODO: Implementar movimiento a la izquierda
    JP gameLoop

fin_juego:
    CALL CLEARSCR   ; Borrar pantalla
    CALL despedida
    ;TODO Pintar bien la piececita segun el jugador activo (color en D)

; Constantes para el tablero
COLUMNA_INICIAL     EQU 2       ; Primera columna del tablero
COLUMNA_MAXIMA      EQU 26      ; Última columna del tablero
COLUMNA_INCREMENTO  EQU 4       ; Incremento entre columnas (3 de ficha + 1 de borde)

; Constantes de color
COLOR_JUGADOR_1     EQU $10     ; Color rojo para jugador 1
COLOR_JUGADOR_2     EQU $30     ; Color amarillo para jugador 2

; Variables para la posición de la ficha
ficha_fila:    DB 0
ficha_columna: DB 0

; Etiqueta del recurso binario del tablero (archivo .scr)
tablerito: INCBIN "tablerito.scr"



