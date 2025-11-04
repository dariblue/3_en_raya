; Rutina de juego
Juego:
    CALL DrawBoard
    
    CALL Tecla2


    ; Comprobar si se pulsó 'Q' (ziquierda)
    LD A,(Caracter2)
    CP 'Q'
    JR NZ, segunda_lectura   ; Si no es 'Q', comprueba que sea 'W'
    ; TODO Funcionalidad de mover la ficha a la izquierda


    
    RET

; Dibuja el tablero inicial (tablerito.scr) y la ficha del jugador activo
DrawBoard:
    LD HL, tablerito 
    LD DE, $4000  ; Dirección de pantalla en ZX Spectrum
    LD BC, $5B00 - $4000    ; tamaño: $5B00 - $4000 = $1B00 (6912 bytes) tamaño pantalla ZX Spectrum
    LDIR 
    
    ; Pintar ficha inicial del jugador activo usando overlay full-screen
    LD A, 5*8
    CALL Piececita
    RET

Coord_Atrib: ; Copiado del de bienvenida.asm
    PUSH AF             ; Guardamos A en el stack
    PUSH BC             ; Guardamos BC en el stack
    ;LD A, D 
    LD H,B              ; Los bits 4,5 de B deben ser los bits 0,1 de H
    SRL H : SRL H : SRL H
    LD A,B              ; Los bits 0,1,2 de B deben ser los bits 5,6,7 de L
    SLA A : SLA A : SLA A : SLA A : SLA A
    OR C                ; Y C son los bits 0-4 de L
    LD L,A
    LD BC, $5800        ; Le sumamos la dirección de comienzo de los atributos
    ADD HL,BC
    POP BC              ; Restauramos los valores del stack
    POP AF

    RET
    ; TODO: Modificar para que el color venga en D

; Bucle principal: espera tecla, cambia jugador y repinta la ficha
GameLoop: ; TODO (codigo de lectura de tecla pulsada y soltada (enter y F), cambio de jugador y mover/borrar/pintar ficha)
    JP GameLoop  ; Bucle infinito por ahora


Tecla2:                ; Rutina para leer del teclado 'S' o 'N'
    PUSH BC             ; BC al stack para preservar su valor

T2_Q:            
    LD BC,$FBFE         ; Escanear línea T, R, E, W, Q
    IN A,(C)
    BIT 0,A
    JR NZ,T2_W           ; No han pulsado 'Q'
    LD A,'Q'
    CALL T2_S

T2_W:            
    LD BC,$FBFE         ; Escanear línea T, R, E, W, Q
    IN A,(C)
    BIT 1,A
    JR NZ,T2_INTRO           ; No han pulsado 'W'
    LD A,'W'
    CALL T2_S  

T2_INTRO:     
    LD BC,$BFFE         ; Escanear línea H J K L ENTER
    IN A,(C)
    BIT 0,A
    JR NZ,T2_F      ; No han pulsado Intro
    LD A,"E"
    CALL T2_S  

T2_F:            
    LD BC,$FDFE         ; Escanear línea G,F,D,S,A
    IN A,(C)
    BIT 3,A
    JR NZ, T2_Q           ; No han pulsado 'F'
    LD A,'F'
    CALL T2_S 

T2_S:     
    LD (Caracter2),A     ; Guardo 'F' en la Variable Caracter2

Soltar_Tecla2:           ; Rutina de espera hasta que se suelta la tecla
    IN A,(C)            ; Leer del puerto que se ha definido en Lee_Tecla
    AND $1F
    CP $1F              ; Comprobar que no hay tecla pulsada
    JR NZ,Soltar_Tecla2  ; esperar hasta que no haya tecla pulsada
    POP BC              ; Recuperamos el valor de BC
    RET


; Lectura de la tecla pulsada y acción correspondiente
segunda_lectura:
    LD A,(Caracter2)
    CP 'W' 

    JR NZ, tercera_lectura   ; Si no es 'W', comprueba que sea 'ENTER'
    ; TODO Funcionalidad de mover la ficha a la derecha

tercera_lectura:
    LD A,(Caracter2)
    CP "E"
    JR NZ, fin_juego       ; Si no es 'ENTER', asume q es F y termina el juego
    CALL cambiar_jugapuertas
    CALL Tecla2

fin_juego:
    CALL CLEARSCR   ; Borrar pantalla
    CALL Despedida ; Llamar a la rutina de pantalla final


Piececita:
    ; Pintar ficha en fila=2, col=2 usando atributo que deja Coord_Atrib (lee D para color)
    LD B, 2
    LD C, 2
    
    CALL Coord_Atrib   ; HL -> addr atributo (Coord_Atrib preserva AF), D tiene color
    LD (HL), A
    INC HL
    LD (HL), A
    INC HL
    LD (HL), A

    ; atributos en la fila inferior de la celda (fila+1)
    INC B
    CALL Coord_Atrib
    LD (HL), A
    INC HL
    LD (HL), A
    INC HL
    LD (HL), A
    RET
    ;TODO Pintar bien la piececita segun el jugador activo (color en D)

; Etiqueta del recurso binario del tablero (archivo .scr)
tablerito: INCBIN "tablerito.scr"
Caracter2:  db 0,0  ; Mensaje del carácter para imprimir



