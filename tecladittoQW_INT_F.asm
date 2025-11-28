tecladoQW_INT_F:
;Código completo del tecladito para Q, W, S (Jugador 1) y O, P, L (Jugador 2) y F (Fin)
    PUSH BC             ; BC al stack para preservar su valor

teclado_loop:

    ; --- JUGADOR 1 ---
    ; Q (Izquierda) - Puerto $FBFE, Bit 0
    LD BC,$FBFE         
    IN A,(C)
    BIT 0,A
    JR NZ,check_W       ; No es Q
    LD A,'Q'
    JR T_FIN

check_W:
    ; W (Derecha) - Puerto $FBFE, Bit 1
    LD BC,$FBFE         
    IN A,(C)
    BIT 1,A
    JR NZ,check_S       ; No es W
    LD A,'W'
    JR T_FIN

check_S:
    ; S (Soltar) - Puerto $FDFE, Bit 1 (A, S, D, F, G)
    LD BC,$FDFE
    IN A,(C)
    BIT 1,A
    JR NZ,check_O       ; No es S
    LD A,'S'
    JR T_FIN

    ; --- JUGADOR 2 ---
check_O:
    ; O (Izquierda) - Puerto $DFFE, Bit 1 (P, O, I, U, Y)
    LD BC,$DFFE
    IN A,(C)
    BIT 1,A
    JR NZ,check_P       ; No es O
    LD A,'O'
    JR T_FIN

check_P:
    ; P (Derecha) - Puerto $DFFE, Bit 0 (P, O, I, U, Y)
    LD BC,$DFFE
    IN A,(C)
    BIT 0,A
    JR NZ,check_L       ; No es P
    LD A,'P'
    JR T_FIN

check_L:
    ; L (Soltar) - Puerto $BFFE, Bit 1 (Enter, L, K, J, H)
    LD BC,$BFFE
    IN A,(C)
    BIT 1,A
    JR NZ,check_F       ; No es L
    LD A,'L'
    JR T_FIN

    ; --- GLOBAL ---
check_F:
    ; F (Fin) - Puerto $FDFE, Bit 3 (A, S, D, F, G)
    LD BC,$FDFE
    IN A,(C)
    BIT 3,A
    JR NZ, teclado_loop ; Si no es ninguna, volver a empezar
    LD A,'F'

T_FIN:
    PUSH AF             ; Guardamos el código de la tecla (A)
    CALL Soltar_Tecla2  ; Esperar a que se suelte la tecla (destruye A)
    POP AF              ; Recuperamos el código de la tecla
    POP BC              ; Recuperar BC del stack
    RET