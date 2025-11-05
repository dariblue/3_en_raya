;Código completo del tecladito
Teclado:
    PUSH BC             ; BC al stack para preservar su valor

T_N:
    LD BC,$7FFE         ; Escanear línea B,N,M,SYMB,Space
    IN A,(C)
    BIT 3,A
    JR NZ,T_S           ; Han pulsado N
    LD A,'N'
    JR T_Save

T_S:            
    LD BC,$FDFE         ; Escanear línea G,F,D,S,A
    IN A,(C)
    BIT 1,A
    JR NZ,T_Q           ; No han pulsado 'S'
    LD A,'S'
    JR T_Save

T_Q:            
    LD BC,$FBFE         ; Escanear línea T, R, E, W, Q
    IN A,(C)
    BIT 0,A
    JR NZ,T_W           ; No han pulsado 'Q'
    LD A,'Q'
    JR T_Save

T_W:            
    LD BC,$FBFE         ; Escanear línea T, R, E, W, Q
    IN A,(C)
    BIT 1,A
    JR NZ,T_INTRO           ; No han pulsado 'W'
    LD A,'W'
    JR T_Save

T_INTRO:     
    LD BC,$BFFE         ; Escanear línea H J K L ENTER
    IN A,(C)
    BIT 0,A
    JR NZ,T_F      ; No han pulsado Intro
    LD A,"E"
    JR T_Save

T_F:            
    LD BC,$FDFE         ; Escanear línea G,F,D,S,A
    IN A,(C)
    BIT 3,A
    JR NZ, T_N          ; No han pulsado 'F'
    LD A,'F'
    JR T_Save

T_Save:     
    LD (Caracter),A     ; Guardar el carácter pulsado en la variable Caracter

Soltar_Tecla:           ; Rutina de espera hasta que se suelta la tecla
    IN A,(C)            ; Leer del puerto que se ha definido en Lee_Tecla
    AND $1F
    CP $1F              ; Comprobar que no hay tecla pulsada
    JR NZ,Soltar_Tecla  ; esperar hasta que no haya tecla pulsada
    POP BC              ; Recuperamos el valor de BC

T_selected:
    LD A,(Caracter) ; Cargar el carácter pulsado en A
    CP 'N' 
    JP Z, si_o_no 
    CP 'S'
    JP Z, si_o_no

    CP 'Q'
    JP Z, mover_izq
    CP 'W'
    JP Z, mover_dcha    
    CP 'E'
    JP Z, cambiar_jugapuertas
    CP 'F'
    JP Z, fin_juego

Caracter:  db 0,0              ; Mensaje del carácter para imprimir


