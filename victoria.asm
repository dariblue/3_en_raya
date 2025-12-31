; ==============================================================================
; Rutina: victoria
; Entrada: Ninguna
; Salida: Muestra la pantalla de título
; Datos del programa: elreal.scr, Titulo, Mensaje
; ==============================================================================

victoria:
    LD A, 0         ; Inicializar el registro A con 0
    OUT ($FE), A    ; Pone el borde de la pantalla en negro
    CALL CLEARSCR   ; Borrar pantalla

    ; Pintar la pantalla de victoria
    LD HL, XD2       ; Dirección del bucle que pinta la pantalla
    LD DE, $4000    
    LD BC, $5B00 - $4000 
    LDIR          

    ; ; Título de victoria   
    ; LD A,2+$80      ; Letra roja, fondo negro, parpadeante
    ; LD B,1          ; Coordenadas (filas) para pintar el título
    ; LD C,4          ; Coordenadas (columnas) para pintar el título
    ; LD IX, Titulo2   ; Dirección del título
    ; CALL PRINTAT    ; Imprime el título

    ; Mensaje de victoria
    LD A,3          ; Letra moradito Vegetta, fondo negro
    LD B,12         ; Coordenadas (filas) para pintar el mensaje
    LD C,1          ; Coordenadas (columnas) para pintar el mensaje
    LD IX, Mensaje2  ; Dirección del mensaje
    CALL PRINTAT    ; Imprime el mensaje

    RET
;-------------------------------------------------------------------------------------
XD2: INCBIN "vctoria.scr"
; Titulo2: db "Victoria en Conecta 4",0    ; Título
Mensaje2: db "¡Felicidades!",0   ; Mensaje de victoria