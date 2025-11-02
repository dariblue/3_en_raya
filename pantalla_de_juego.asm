; Rutina de juego
Juego:
    CALL DrawBoard
    CALL GameLoop
    RET

; Dibuja tablero copiando la imagen "tablerito" a la pantalla ($4000)
DrawBoard:
    LD HL, tablerito
    LD DE, $4000
    LD BC, $5B00 - $4000    ; tamaño: $5B00 - $4000 = $1B00 (6912 bytes)
    LDIR

    ; Pintar ficha inicial del jugador activo usando overlay full-screen
    CALL PaintPiece_FullScreen
    RET

; Bucle principal: espera tecla, cambia jugador y repinta la ficha
GameLoop:
WaitKey:
    ; Lectura simple: detecta cualquier pulsación.
    LD BC, $7FFE
    IN A,(C)
    CP 255
    JR Z, WaitKey     ; sin pulsación -> seguir esperando

    ; Opcional: esperar a soltar para evitar rebotes (si tienes Soltar_Tecla)
    ; CALL Soltar_Tecla

    ; Cambiar jugador (usa la rutina renombrada)
    CALL cambiar_jugapuertas

    ; Repintar la ficha en pantalla con el recurso correspondiente
    CALL PaintPiece_FullScreen

    JR WaitKey

; Pintar ficha usando overlay full-screen según jugador activo (D)
; Asume que pittorojo.scr y fichaamarilla.scr son imágenes full-screen (6912 bytes)
PaintPiece_FullScreen:
    ; Entrada: D = color actual (2 = pittorojo, 6 = fichaamarilla)
    LD A, D
    CP 2
    JR Z, Use_Pittorojo
    CP 6
    JR Z, Use_FichaAmarilla
    RET                 ; color desconocido -> no pintar

Use_Pittorojo:
    LD HL, pittorojo
    JR DoBlit

Use_FichaAmarilla:
    LD HL, fichaamarilla

DoBlit:
    LD DE, $4000
    LD BC, $5B00 - $4000    ; 6912 bytes = tamaño pantalla ZX Spectrum
    LDIR
    RET

; Etiqueta del recurso binario del tablero (archivo .scr)
tablerito: INCBIN "tablerito.scr"

; INCBIN recursos de fichas (full-screen overlays)
pittorojo:      INCBIN "pittorojo.scr"
fichaamarilla:  INCBIN "fichamarilla.scr"