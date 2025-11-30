bienvenida:
    LD A, 0         ; Inicializar el registro A con 0
    OUT ($FE), A    ; Pone el borde de la pantalla en negro
    CALL CLEARSCR   ; Borrar pantalla

    ; Pintar la pantalla de bienvenida
    LD HL, XD       ; Dirección del bucle que pinta la pantalla
    LD DE, $4000    
    LD BC, $5B00 - $4000 
    LDIR          

    ; Título de bienvenida   
    LD A,2+$80      ; Letra roja, fondo negro, parpadeante
    LD B,1          ; Coordenadas (filas) para pintar el título
    LD C,4          ; Coordenadas (columnas) para pintar el título
    LD IX, Titulo   ; Dirección del título
    CALL PRINTAT    ; Imprime el título

    ; Mensaje de bienvenida (comenzar partida)
    LD A,3          ; Letra moradito Vegetta, fondo negro
    LD B,21         ; Coordenadas (filas) para pintar el mensaje
    LD C,1          ; Coordenadas (columnas) para pintar el mensaje
    LD IX, Mensaje  ; Dirección del mensaje
    CALL PRINTAT    ; Imprime el mensaje

    RET
;-------------------------------------------------------------------------------------
XD: INCBIN "elreal.scr"
Titulo: db "Bienvenido al Conecta 4",0    ; Título
Mensaje: db "Empezamos una partida (S/N)?",0   ; Mensaje inicial