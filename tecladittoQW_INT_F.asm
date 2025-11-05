tecladoQW_INT_F:
;Código completo del tecladito para Q W INTRO y F
    PUSH BC             ; BC al stack para preservar su valor

T_Q:            
    LD BC,$FBFE         ; Escanear línea T, R, E, W, Q
    IN A,(C)
    BIT 0,A
    JR NZ,T_W           ; No han pulsado 'Q'
    LD A,'Q'
    JR T_FIN

T_W:            
    LD BC,$FBFE         ; Escanear línea T, R, E, W, Q
    IN A,(C)
    BIT 1,A
    JR NZ,T_INTRO           ; No han pulsado 'W'
    LD A,'W'
    JR T_FIN

T_INTRO:     
    LD BC,$BFFE         ; Escanear línea H J K L ENTER
    IN A,(C)
    BIT 0,A
    JR NZ,T_F      ; No han pulsado Intro
    LD A,"E"
    JR T_FIN

T_F:            
    LD BC,$FDFE         ; Escanear línea G,F,D,S,A
    IN A,(C)
    BIT 3,A
    JR NZ, T_Q          ; No han pulsado 'F'
    LD A,'F'

T_FIN:
    CALL Soltar_Tecla2   ; Esperar a que se suelte la tecla
    POP BC              ; Recuperar BC del stack
    RET