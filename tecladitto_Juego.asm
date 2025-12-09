; ==============================================================================
; Rutina: teclado_Juego
; Entrada: color_jugador (para determinar teclas)
; Salida: A (-1: Izq, 1: Der, 0: Bajar, $FE: Fin)
; Datos del programa: Puertos de E/S
; ==============================================================================

teclado_Juego:
    PUSH BC             ; BC al stack para preservar su valor

teclado_loop_check:
    ; Verificar jugador actual
    LD A, (color_jugador)
    CP $10              ; ¿Es Jugador 1 (Rojo)?
    JR Z, check_j1

    ; --- JUGADOR 2 (Amarillo) ---
    ; O (Izquierda)
    LD BC,$DFFE
    IN A,(C)
    BIT 1,A
    JR Z, ret_izq       ; Pulsado O -> Izquierda

    ; P (Derecha)
    LD BC,$DFFE
    IN A,(C)
    BIT 0,A
    JR Z, ret_dcha      ; Pulsado P -> Derecha

    ; L (Bajar)
    LD BC,$BFFE
    IN A,(C)
    BIT 1,A
    JR Z, ret_bajar     ; Pulsado L -> Bajar

    JR check_fin        ; Comprobar F

check_j1:
    ; --- JUGADOR 1 (Rojo) ---
    ; Q (Izquierda)
    LD BC,$FBFE         
    IN A,(C)
    BIT 0,A
    JR Z, ret_izq       ; Pulsado Q -> Izquierda

    ; W (Derecha)
    LD BC,$FBFE         
    IN A,(C)
    BIT 1,A
    JR Z, ret_dcha      ; Pulsado W -> Derecha

    ; S (Bajar)
    LD BC,$FDFE
    IN A,(C)
    BIT 1,A
    JR Z, ret_bajar     ; Pulsado S -> Bajar

check_fin:
    ; F (Fin) - Global
    LD BC,$FDFE
    IN A,(C)
    BIT 3,A
    JR Z, ret_fin

    JR teclado_loop_check ; Esperar hasta que se pulse algo

ret_izq:
    LD A, $FF           ; -1
    JR T_SALIDA
ret_dcha:
    LD A, 1             ; 1
    JR T_SALIDA
ret_bajar:
    LD A, 0             ; 0
    JR T_SALIDA
ret_fin:
    LD A, $FE           ; Código de fin
    JR T_SALIDA

T_SALIDA:
    PUSH AF             ; Guardar resultado
    CALL Soltar_Tecla  ; Esperar a soltar
    POP AF              ; Recuperar resultado
    POP BC              ; Recuperar BC
    RET


; TS_Q:
;     LD BC,$FBFE         ; Escanear línea T,R,E,W,Q 
;     IN A,(C)
;     BIT 0,A
;     JR NZ,TS_W          ; No han pulsado 'Q' salta a W
;     LD A,'Q'
;     JR TS_FIN

; TS_W:            
;     LD BC,$FBFE         ; Escanear línea T,R,E,W,Q 
;     IN A,(C)
;     BIT 1,A
;     JR NZ,TS_F          ; No han pulsado 'W' salta a F
;     LD A,'W'
;     JR TS_FIN

; TS_F:            
;     LD BC,$FDFE         ; Escanear línea G,F,D,S,A
;     IN A,(C)
;     BIT 3,A
;     JR NZ,TS_ENTER      ; No han pulsado 'F' salta a ENTER
;     LD A,'F'
;     JR TS_FIN

; TS_ENTER:
;     LD BC,$BFFE         ; Escanear línea H,J,K,L,ENTER
;     IN A,(C)
;     BIT 0,A
;     JR NZ,TS_Q          ; No han pulsado 'ENTER' salta a Q
;     LD A,'*'

; TS_FIN:
;     PUSH AF             ; Guardar A (contiene 'S' o 'N')
;     CALL Soltar_Tecla   ; Esperar a que se suelte la tecla
;     POP AF              ; Restaurar A con la tecla detectada
;     POP BC              ; Recuperar BC del stack
;     RET    