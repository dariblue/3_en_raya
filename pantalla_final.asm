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

Titulo_final:    db "Partida epiquisima bro",0    ; Título
Mensaje_final:   db "Quieres jugar de nuevo (S/N)? ",0   ; Mensaje inicial
