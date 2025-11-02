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

    ; Dirección del bitmap para fila=12,col=15 calculada previamente:
    ; offset = (12*32) + 15 = 3087 -> $C0F ; dirección = $4000 + $C0F = $4C0F
    LD HL,$4C0F      ; inicio del bloque de píxels para esa casilla

    ; Usamos DE como puntero para escribir bytes
    LD D,H
    LD E,L

    ; Primera fila de bytes (3 columnas)
    LD A,%00011000
    LD (DE),A
    INC E
    LD A,%00100100
    LD (DE),A
    INC E
    LD A,%01000010
    LD (DE),A

    ; Segunda fila: DE = base + 256 (siguiente línea de pixels)
    LD D,H
    LD E,L
    INC D            ; +256
    LD A,%01111110
    LD (DE),A
    INC E
    LD A,%11100111
    LD (DE),A
    INC E
    LD A,%01111110
    LD (DE),A

    RET

; Etiqueta del recurso binario del tablero (archivo .scr)
tablerito: INCBIN "tablerito.scr"


