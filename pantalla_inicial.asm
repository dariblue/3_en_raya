bienvenida:
    LD A, 0       ; Inicializar el registro A en 0 (color)
    OUT ($FE), A  ; Configurar el color de borde de la pantalla (negro)
    CALL CLEARSCR ; Borrar la pantalla

    ; Pintar la pantalla de bienvenida
    LD HL, XD       ; Dirección del bucle que pinta la pantalla
    LD DE, $4000    
    LD BC, $5B00 - $4000 
    LDIR          

    ; Título de bienvenida   
    LD A,15+$80     ; Letra blanca, fondo azul parpadeante
    LD B,1          ; Coordenadas (filas) para pintar el título
    LD C,5          ; Coordenadas (columnas) para pintar el título
    LD IX, Titulo   ; Dirección del título
    CALL PRINTAT    ; Imprime el título

    ; Mensaje de bienvenida (comenzar partida)
    LD A,11          ; Letra moradito Vegetta, fondo azul
    LD B,21         ; Coordenadas (filas) para pintar el mensaje
    LD C,2          ; Coordenadas (columnas) para pintar el mensaje
    LD IX, Mensaje  ; Dirección del mensaje
    CALL PRINTAT    ; Imprime el mensaje

    RET

;-------------------------------------------------------------------------------------
XD: INCBIN "elreal.scr"
Titulo: db "Bienvenido al Conecta 4",0    ; Título
Mensaje: db "Empezamos una partida (S/N)?",0   ; Mensaje inicial