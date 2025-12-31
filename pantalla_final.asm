; ==============================================================================
; Rutina: despedida
; Entrada: Ninguna
; Salida: Muestra la pantalla final y mensaje de jugar de nuevo
; Datos del programa: Titulo_final, Mensaje_final
; ==============================================================================

despedida: 
    CALL CLEARSCR   ; Borrar pantalla
    LD A, 0         ; Inicializar el registro A con 0
    OUT ($FE), A    ; Pone el borde de la pantalla en negro

    ; Pintar la pantalla de bienvenida
    LD HL, CARITA       ; Dirección del bucle que pinta la pantalla
    LD DE, $4000    
    LD BC, $5B00 - $4000 
    LDIR       

    ; Título de despedida
    LD A,3+$80      ; Letra moradita, fondo negro, parpadeante
    LD B,1          ; Coordenadas para pintar el título
    LD C,4       
    LD IX,Titulo_final    ; Dirección del título
    CALL PRINTAT    ; Imprime el título

    ; Mensaje despedida
    LD A,13          ; Letra azulita, fondo negro
    LD B,20       ; Coordenadas para pintar el mensaje
    LD C,1       
    LD IX,Mensaje_final   ; Dirección del mensaje
    CALL PRINTAT    ; Imprime el mensaje

    RET

CARITA: INCBIN "carita.scr"
Titulo_final:    db "Partida epiquisima bro", 0    ; Título
Mensaje_final:   db "Quieres jugar de nuevo (S/N)? ",0   ; Mensaje inicial
Adios_final:     db "Gracias por jugar. Adios!",0 ; Mensaje de despedida