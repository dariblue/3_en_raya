;Código del estudiante
Inicializar:
    CALL inic_jugadores    ; establecer jugadores (DE = activo, DE' = otro)
    CALL Juego             ; Llamar a la rutina de juego
    RET

; Inicializa jugadores con valores:
; En D = color ficha jugador activo, E = nº jugador activo
; En D'/E' = color y nº del otro jugador (registros primados)
inic_jugadores:
    ; Jugador activo (primarios): J1 = ROJO, nº 1
    LD D, 2      ; color ficha jugador1 = 2 (rojo)
    LD E, 1      ; nº jugador1 = 1

    EXX          ; pasar a registros primados (trabajamos en DE' como DE)
    ; Otro jugador (primados): J2 = AMARILLO, nº 2
    LD D, 6      ; color ficha jugador2 = 6 (amarillo)
    LD E, 2      ; nº jugador2 = 2

    ;EXX          ; volver a registros primarios: DE contiene J1, DE' contiene J2
    RET

; Cambia jugador activo <-> otro usando EXX (muy barato)
cambiar_jugapuertas:
    EXX
    RET

