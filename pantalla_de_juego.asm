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

; Bucle principal: espera tecla, cambia jugador y repinta la ficha
GameLoop: ; TODO (codigo de lectura de tecla pulsada y soltada (enter y F), cambio de jugador y mover/borrar/pintar ficha)
    JP GameLoop  ; Bucle infinito por ahora

;TODO rutina de esperar tecla (bienvenida tiene una similar)

Piececita: 
    ; Aquí se pintaría la ficha del jugador activo en la posición inicial

    ; Poner el atributo (color) de la ficha
    LD A,D        ; cargar color desde la variable/etiqueta D (como tenías)
    LD B,2
    LD C,2
    CALL Coor_Atrib  ; HL = dirección del atributo
    LD (HL),A        ; escribir color
    INC HL
    LD (HL),A
    INC HL
    LD (HL),A
    INC B
    CALL Coor_Atrib
    LD (HL),A
    INC HL
    LD (HL),A
    INC HL
    LD (HL),A

    RET

; Etiqueta del recurso binario del tablero (archivo .scr)
tablerito: INCBIN "tablerito.scr"


