; Rutina de bienvenida para el juego Conecta 4
; Se incluye desde el programa principal
Bienvenida:
    LD A, 0
    OUT ($FE),A     ; Poner el borde de la pantalla negro
    CALL CLEARSCR   ; Borrar pantalla

    LD HL, XD
    LD DE, $4000
    LD BC, $5B00 - $4000
    LDIR  
    

    LD A,2+$80      ; Letra roja, fondo negro, parpadeante
    LD B,1          ; Coordenadas para pintar el título
    LD C,4       
    LD IX,Titulo    ; Dirección del título
    CALL PRINTAT    ; Imprime el título

    LD A,3          ; Letra moradito Vegetta, fondo negro
    LD B,21         ; Coordenadas para pintar el mensaje
    LD C,1       
    LD IX,Mensaje   ; Dirección del mensaje
    CALL PRINTAT    ; Imprime el mensaje

    LD A,1+$80      ; Azul parpadeante
    LD B,21         ; Buscamos la dirección del atributo de coordenadas 21,30
    LD C,30         ; Para poner el cursor
    CALL Coor_Atrib ; Esta rutina devuelve en HL la dirección del atributo
    LD (HL),A       ; Pongo el atributo

    CALL Teclado    ; Leo el teclado hasta que pulsen S o N

    LD A,1          ; Eco de la tecla pulsada
    LD B,21
    LD C,30
    LD IX,Caracter
    CALL PRINTAT

    CALL CLEARSCR       ; Borrar pantalla
    
    LD A,7          ; Letra azul, fondo negro
    LD B,18         ; Coordenadas para pintar el mensaje
    LD C,1       
    LD IX,Respuesta   ; Dirección del mensaje
    CALL PRINTAT    ; Imprime el mensaje
    LD A,4
    LD B,18
    LD C,17
    LD IX,Caracter
    CALL PRINTAT

    ; Comprobar si se pulsó 'N'
    LD A,(Caracter)
    CP 'N'
    JR NZ, fin_bienvenida   ; Si no es 'N', salir

    ; Si es 'N', mostrar mensaje de despedida
    LD A,4          ; Color verde
    LD B,10         ; Fila 10
    LD C,1          ; Columna 1
    LD IX,Adios     ; Mensaje de despedida
    CALL PRINTAT    ; Mostrar mensaje
    HALT            ; Detener la ejecución
    


fin_bienvenida: ;Va al juego
    CALL CLEARSCR   ; Borrar pantalla
    CALL Juego    ; rutina de juego 

Coor_Atrib:
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

Teclado:                ; Rutina para leer del teclado 'S' o 'N'
    PUSH BC             ; BC al stack para preservar su valor
T_N:
    LD BC,$7FFE         ; Escanear línea B,N,M,SYMB,Space
    IN A,(C)
    BIT 3,A
    JR NZ,T_S           ; Han pulsado N
    LD A,'N'
    
    JR T_F
T_S:            
    LD BC,$FDFE         ; Escanear línea G,F,D,S,A
    IN A,(C)
    BIT 1,A
    JR NZ,T_N           ; No han pulsado 'S'
    LD A,'S'
T_F:     
    LD (Caracter),A     ; Guardo 'S' o 'N' en la Variable Caracter 

Soltar_Tecla:           ; Rutina de espera hasta que se suelta la tecla
    IN A,(C)            ; Leer del puerto que se ha definido en Lee_Tecla
    AND $1F
    CP $1F              ; Comprobar que no hay tecla pulsada
    JR NZ,Soltar_Tecla  ; esperar hasta que no haya tecla pulsada
    POP BC              ; Recuperamos el valor de BC
    RET

Titulo:    db "Bienvenido al Conecta 4",0    ; Título
Mensaje:   db "Empezamos una partida (S/N)? ",0   ; Mensaje inicial
Respuesta: db "Has contestado: ",0      ; Mensaje con la respuesta
Caracter:  db 0,0              ; Mensaje del carácter para imprimir
Adios:     db "Gracias por jugar. Adios!",0 ; Mensaje de despedida
XD:        INCBIN "elreal.scr"