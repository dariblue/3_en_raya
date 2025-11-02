;Codigo previo al juego que inicializa jugadores y llama a la rutina de juego
Inicializar:
    CALL inic_jugadores    ; Inicializar jugadores
    CALL Juego             ; Llamar a la rutina de juego
    RET

; Inicializa jugadores con valores:
; En D = color ficha jugad or activo, E = nº jugador activo (primarios)
; En D'/E' = color y nº del otro jugador (secundarios)
inic_jugadores:
    ; Jugador activo (primario) J1 = ROJO, nº 1
    LD D, 2      ; color ficha J1 = 2 (rojo)
    LD E, 1      ; nº jugador1 = 1

    EXX          ; cambio del registro primario a secundario

    ; Otro jugador (secundario): J2 = AMARILLO, nº 2
    LD D, 6      ; color ficha J2 = 6 (amarillo)
    LD E, 2      ; nº jugador2 = 2

    ; EXX          ; volver a registros primarios: DE contiene J1, (DE)' contiene J2
    RET

; Cambia el jugador activo (primario <-> secundario)
cambiar_jugapuertas:
    EXX
    RET

