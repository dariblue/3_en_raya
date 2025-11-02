; Rutina de juego
Juego:
    CALL DrawBoard
    
    CALL GameLoop
    RET

; Dibuja el tablero inicial (tablerito.scr) y la ficha del jugador activo
DrawBoard:
    LD HL, tablerito 
    LD DE, $4000  ; Dirección de pantalla en ZX Spectrum
    LD BC, $5B00 - $4000    ; tamaño: $5B00 - $4000 = $1B00 (6912 bytes) tamaño pantalla ZX Spectrum
    LDIR 

    ; Pintar ficha inicial del jugador activo usando overlay full-screen
    CALL Piececita
    RET

Coord_Atrib:
    ; Entrada: H = fila (0..23), L = columna (0..31)
    ; Salida:  HL = $5800 + fila*32 + columna, A = atributo (tomado de D)
    LD C, L        ; guardar columna
    LD L, H        ; L := fila
    LD H, 0
    ; desplazar HL << 5 (multiplicar por 32) usando SLA/ RL (5 veces)
    SLA L
    RL  H
    SLA L
    RL  H
    SLA L
    RL  H
    SLA L
    RL  H
    SLA L
    RL  H
    ; insertar columna en los 5 bits bajos
    LD A, L
    OR C
    LD L, A
    ; añadir base $5800 (H es pequeño, OR es válido)
    LD A, H
    OR $58
    LD H, A

    ; preparar atributo en A usando D (ink 0..7). Quitando BRIGHT para evitar colores raros.
    LD A, D
    AND 7
    RET

; Bucle principal: espera tecla, cambia jugador y repinta la ficha
GameLoop: ; TODO (codigo de lectura de tecla pulsada y soltada (enter y F), cambio de jugador y mover/borrar/pintar ficha)
    JP GameLoop  ; Bucle infinito por ahora

;TODO rutina de esperar tecla (bienvenida tiene una similar)

Piececita:
    ; Pintar ficha en fila=2, col=2 usando atributo que deja Coord_Atrib (lee D para color)
    LD H, 2
    LD L, 2
    CALL Coord_Atrib   ; HL -> addr atributo, A <- (D & 7)
    LD (HL), A
    INC HL
    LD (HL), A
    INC HL
    LD (HL), A

    ; atributos en la fila inferior de la celda (fila+1)
    LD H, 3
    LD L, 2
    CALL Coord_Atrib
    LD (HL), A
    INC HL
    LD (HL), A
    INC HL
    LD (HL), A

    RET

; Etiqueta del recurso binario del tablero (archivo .scr)
tablerito: INCBIN "tablerito.scr"


