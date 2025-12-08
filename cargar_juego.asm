inicializar:
    CALL inic_jugadores  ; Inicializar los jugadores
    CALL dibujarTablero  ; Dibujar el tablero
    ;CALL dibujar_ficha
    RET

inic_jugadores:
    ; Jugador activo (primario) J1 = ROJO, nº 1
    LD D, 2      ; color ficha J1 = 2 (rojo)
    LD E, 1      ; nº jugador1 = 1

    EXX          ; cambio del registro primario a secundario

    ; Otro jugador (secundario): J2 = AMARILLO, nº 2
    LD D, 6      ; color ficha J2 = 6 (amarillo)
    LD E, 2      ; nº jugador2 = 2

    EXX          ; volver a registros primarios: DE contiene J1, (DE)' contiene J2
    RET

; Cambia el jugador activo (primario <-> secundario)
cambiar_jugapuertas:
    EXX
    RET

;-----------------------------------------------------------------------------------------------------
; ETIQUETAS 7 CONSTANTES Y VARIABLES DEL JUEGO
; Etiqueta del recurso binario del tablero (archivo .scr)
tablerito: INCBIN "tablerito.scr" ; Recurso binario del tablero de Conecta 4
; Constantes para el tablero
COLUMNA_INICIAL     EQU 2       ; Primera columna del tablero
COLUMNA_INCREMENTO  EQU 4       ; Incremento entre columnas (3 de ficha + 1 de borde)
COLUMNA_MAXIMA      EQU COLUMNA_INICIAL + (8 * COLUMNA_INCREMENTO)  ; Última columna (7 columnas: 0-6)

; Constantes de color
COLOR_JUGADOR_1     EQU $10     ; Color rojo para jugador 1
COLOR_JUGADOR_2     EQU $30     ; Color amarillo para jugador 2
COLOR_FONDO         EQU $07     ; Color de fondo del tablero (blanco sobre negro)

; Variables para la posición de la ficha
ficha_fila:     DB 0
ficha_columna:  DB 0
color_jugador:  DB $10   ; Jugador actual ($10 = Rojo, $30 = Amarillo)
TamColumna:     EQU 8
Fichas0:        DB $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF     ; Columna inicio    
Fichas:
                DB $FF, 0, 0, 0, 0, 0, 0, $FF    ; Columna 0
                DB $FF, 0, 0, 0, 0, 0, 0, $FF    ; Columna 1
                DB $FF, 0, 0, 0, 0, 0, 0, $FF    ; Columna 2
                DB $FF, 0, 0, 0, 0, 0, 0, $FF    ; Columna 3
                DB $FF, 0, 0, 0, 0, 0, 0, $FF    ; Columna 4
                DB $FF, 0, 0, 0, 0, 0, 0, $FF    ; Columna 5
                DB $FF, 0, 0, 0, 0, 0, 0, $FF    ; Columna 6
                DB $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF     ; Columna cierre