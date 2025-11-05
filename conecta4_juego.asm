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
    
    ; Pintar ficha inicial del jugador activo usando overlay full-screen
    LD A, 5*8
    CALL piececita
    RET

; Coord_Atrib: ; Copiado del de bienvenida.asm ;TODO: pasar a mannin.asm
;     PUSH AF             ; Guardamos A en el stack
;     PUSH BC             ; Guardamos BC en el stack
;     ;LD A, D 
;     LD H,B              ; Los bits 4,5 de B deben ser los bits 0,1 de H
;     SRL H : SRL H : SRL H
;     LD A,B              ; Los bits 0,1,2 de B deben ser los bits 5,6,7 de L
;     SLA A : SLA A : SLA A : SLA A : SLA A
;     OR C                ; Y C son los bits 0-4 de L
;     LD L,A
;     LD BC, $5800        ; Le sumamos la dirección de comienzo de los atributos
;     ADD HL,BC
;     POP BC              ; Restauramos los valores del stack
;     POP AF

;     RET
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



