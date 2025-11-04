; Rutina de despedida para el juego Conecta 4
; Se incluye desde el programa principal

Despedida:
    CALL CLEARSCR   ; Borrar pantalla
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
    CALL Coor_Atrib ; Esta rutina devuelve en HL la dirección del atributo
    LD (HL),A       ; Pongo el atributo

    CALL Teclado    ; Leo el teclado hasta que pulsen S o N

    LD A,1          ; Eco de la tecla pulsada
    LD B,20
    LD C,30
    LD IX,Caracter_final
    CALL PRINTAT

    CALL CLEARSCR       ; Borrar pantalla
    
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
    JR NZ, fin_despedida   ; Si no es 'N', inicializar el juego de nuevo

    ; Si es 'N', mostrar mensaje de despedida
    LD A,4          ; Color verde
    LD B,10         ; Fila 10
    LD C,1          ; Columna 1
    LD IX,Adios_final     ; Mensaje de despedida
    CALL PRINTAT    ; Mostrar mensaje
    HALT            ; Detener la ejecución

fin_despedida: ;Va a juegar de nuevo
    CALL CLEARSCR   ; Borrar pantalla
    CALL Inicializar ; Llamar a la rutina de inicialización




Titulo_final:    db "Partida epiquisima bro",0    ; Título
Mensaje_final:   db "Quieres jugar de nuevo (S/N)? ",0   ; Mensaje inicial
Respuesta_final: db "Has contestado: ",0      ; Mensaje con la respuesta
Caracter_final:  db 0,0              ; Mensaje del carácter para imprimir
Adios_final:     db "Gracias por jugar. Adios!",0 ; Mensaje de despedida
