despedida: 
    CALL CLEARSCR   ; Borrar pantalla
    LD A, 0         ; Inicializar el registro A con 0
    OUT ($FE), A    ; Pone el borde de la pantalla en negro

    ; Título de despedida
    LD A,3+$80      ; Letra moradita, fondo negro, parpadeante
    LD B,1          ; Coordenadas para pintar el título
    LD C,11       
    LD IX, Titulo_final    ; Dirección del título
    CALL PRINTAT    ; Imprime el título

    ; Mensaje despedida
    LD A,13          ; Letra azulita, fondo negro
    LD B,20       ; Coordenadas para pintar el mensaje
    LD C,1       
    LD IX, Mensaje_final   ; Dirección del mensaje
    CALL PRINTAT    ; Imprime el mensaje

    RET

;-------------------------------------------------------------------------------------
Titulo_final:    db "Epico bro", 0    ; Título
Mensaje_final:   db "Quieres jugar de nuevo (S/N)? ",0   ; Mensaje inicial
