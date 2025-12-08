juego: 
    CALL jugar_ficha














    
    ; CALL tecladoQ_W_F_Enter:    ; Rutina para manejar las teclas Q,W,F,ENTER
    ; ; CALL comprobarTecla         ; Comprueba la tecla pulsada y actúa en consecuencia   
    ; CP 'Q'               ; Comprobar si la tecla es 'Q'
    ; CALL Z, mover_izq  ; Si es 'Q', mover a la izquierda
    ; CP 'W'               ; Comprobar si la tecla es 'W'
    ; CALL Z, mover_dcha    ; Si es 'W', mover a la derecha
    ; CP 'F'               ; Comprobar si la tecla es 'F'
    ; CALL Z, fin      ; Si es 'F', redirige a pantalla final
    ; CP '*'               ; Comprobar si la tecla es 'ENTER' (representada por '*')
    ; ; CALL Z, bajar_pieza    ; Si es 'ENTER', bajar la pieza
    ; CALL Z, cambiar_jugapuertas   ; Si es 'ENTER', cambia el jugador actual
    
    ; JP juego                   ; Repetir el bucle del juego

; estructura a seguir en Partida:
; Partida:
;   CALL inicializar
;   CALL tablero
;PT1: 
;   CALL cambiar_jugapuertas
;   CALL jugarFicha
;   CALL BajarFicha
;   CALL comprobar 4 
;   OR A
;   JN NZ, PT2
;   CALL TABLAS
;   OR A
;   JN NZ, finJR Z, PT1
;   MENASJE DE TABLAS Y OTRA PARTIDA
;   RET
;PT2:
;   MENSAJE DE GANADOR Y ORTRA PARTIDA
;   RET



;HACER QUE EL TECLADO DEVUELVA DISTINTOS VALORES DE A SEGÚN LA TECLA PULSADA ( A = -1, 1, 0)
;JUGAR FICHA:
;   LD H, 0
;   CALL PINTAR FICHA
;   CALL LEERTECLADO
;   OR A
;   JR JF1
;   ADD A, L
;   CALL BORRARFICHA
;   LD L, A