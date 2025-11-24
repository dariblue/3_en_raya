; Rutina de juego
juego:
    CALL drawBoard
    CALL tecladoQW_INT_F  ; Llamar a la rutina de lectura de tecla
    RET

; Dibuja el tablero inicial (tablerito.scr) y la ficha del jugador activo
drawBoard:
    LD HL, tablerito 
    LD DE, $4000  ; Dirección de pantalla en ZX Spectrum
    LD BC, $5B00 - $4000    ; tamaño: $5B00 - $4000 = $1B00 (6912 bytes) tamaño pantalla ZX Spectrum
    LDIR 
    
    ; Pintar ficha inicial del jugador activo encima de la primera columna
    ; Coordenadas: Fila 0, Columna 2 (Tablero empieza en 2,2)
    LD H, 0             ; Fila 0
    LD L, 2             ; Columna 2
    LD D, $10           ; Color Rojo (Paper 2 = 010 -> 00 010 000 = $10)
    CALL dibujar_ficha
    RET
    
    ; TODO: Modificar para que el color venga en D

; Bucle principal: espera tecla, cambia jugador y repinta la ficha
gameLoop: ; TODO (codigo de lectura de tecla pulsada y soltada (enter y F), cambio de jugador y mover/borrar/pintar ficha)
    JP gameLoop  ; Bucle infinito por ahora

mover_dcha:
    RET
mover_izq:
    RET

fin_juego:
    CALL CLEARSCR   ; Borrar pantalla
    CALL despedida
    ;TODO Pintar bien la piececita segun el jugador activo (color en D)

; Etiqueta del recurso binario del tablero (archivo .scr)
tablerito: INCBIN "tablerito.scr"



