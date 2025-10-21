; Rutina de despedida para el juego Conecta 4
; Se incluye desde el programa principal

Despedida:
    LD A, 0
    OUT ($FE),A     ; Poner el borde de la pantalla negro

    LD A,3+$80      ; Letra moradita, fondo negro, parpadeante
    LD B,1          ; Coordenadas para pintar el título
    LD C,4       
    LD IX,Titulo_final    ; Dirección del título
    CALL PRINTAT    ; Imprime el título

    LD A,13          ; Letra azulita, fondo negro
    LD B,20       ; Coordenadas para pintar el mensaje
    LD C,1       
    LD IX,Mensaje_final   ; Dirección del mensaje
    CALL PRINTAT    ; Imprime el mensaje

;cursor
    LD A,1+$80      ; Azul parpadeante
    LD B,20         ; Buscamos la dirección del atributo de coordenadas 20,30
    LD C,30         ; Para poner el cursor
    CALL Coor_Atrib2 ; Esta rutina devuelve en HL la dirección del atributo
    LD (HL),A       ; Pongo el atributo

    CALL Teclado2    ; Leo el teclado hasta que pulsen S o N

    LD A,1          ; Eco de la tecla pulsada
    LD B,20
    LD C,30
    LD IX,Caracter_final
    CALL PRINTAT

    LD A,7          ; Letra azul, fondo negro
    LD B,18         ; Coordenadas para pintar el mensaje
    LD C,1       
    LD IX,Respuesta_final   ; Dirección del mensaje
    CALL PRINTAT    ; Imprime el mensaje
    LD A,4
    LD B,18
    LD C,17
    LD IX,Caracter_final
    CALL PRINTAT

    ; Comprobar si se pulsó 'N'
    LD A,(Caracter_final)
    CP 'N'
    JR NZ, fin_despedida   ; Si no es 'N', ir a juego

    ; Si es 'N', mostrar mensaje de despedida
    LD A,4          ; Color verde
    LD B,10         ; Fila 10
    LD C,1          ; Columna 1
    LD IX,Adios_final     ; Mensaje de despedida
    CALL PRINTAT    ; Mostrar mensaje
    HALT            ; Detener la ejecución

fin_despedida:
    CALL CLEARSCR   ; Borrar pantalla
    HALT
    ; CALL Despedida    ; Retornar al programa principal para seguir las siguientes rutinas 
    ; TODO (cambiar cuando tengamos bien la rutina de juego)

Coor_Atrib2:
    ; Rutina que recibe en B,C las coordenadas de la pantalla (fila, columna)
    ; y devuelve en HL la dirección del atributo correspondiente
    PUSH AF             ; Guardamos A en el stack
    PUSH BC             ; Guardamos BC en el stack
    LD H,b              ; Los bits 4,5 de B deben ser los bits 0,1 de H
    SRL H : SRL H : SRL H
    LD A,B              ; Los bits 0,1,2 de B deben ser los bits 5,6,7 de L
    SLA A : SLA A : SLA A : SLA A : SLA a
    OR c                ; Y C son los bits 0-4 de L
    LD L,A
    LD BC, $5800        ; Le sumamos la dirección de comienzo de los atributos
    ADD HL,BC
    POP BC              ; Restauramos los valores del stack
    POP AF
    RET

Teclado2:                ; Rutina para leer del teclado 'S' o 'N'
    PUSH BC             ; BC al stack para preservar su valor
T_N2:
    LD BC,$7FFE         ; Escanear línea B,N,M,SYMB,Space
    IN A,(C)
    BIT 3,A
    JR NZ,T_S2           ; Han pulsado N
    LD A,'N'
    
    JR T_F2
T_S2:            
    LD BC,$FDFE         ; Escanear línea G,F,D,S,A
    IN A,(C)
    BIT 1,A
    JR NZ,T_N2           ; No han pulsado 'S'
    LD A,'S'
T_F2:     
    LD (Caracter_final),A     ; Guardo 'S' o 'N' en la Variable Caracter 
    
Soltar_Tecla2:           ; Rutina de espera hasta que se suelta la tecla
    IN A,(C)            ; Leer del puerto que se ha definido en Lee_Tecla
    AND $1F
    CP $1F              ; Comprobar que no hay tecla pulsada
    JR NZ,Soltar_Tecla2  ; esperar hasta que no haya tecla pulsada
    POP BC              ; Recuperamos el valor de BC
    RET

Titulo_final:    db "Partida epiquisima bro",0    ; Título
Mensaje_final:   db "Quieres jugar de nuevo (S/N)? ",0   ; Mensaje inicial
Respuesta_final: db "Has contestado: ",0      ; Mensaje con la respuesta
Caracter_final:  db 0,0              ; Mensaje del carácter para imprimir
Adios_final:     db "Gracias por jugar. Adios!",0 ; Mensaje de despedida
