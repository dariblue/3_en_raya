adios:
; Rutina para mostrar el mensaje de despedida final
    CALL CLEARSCR       ; Borrar pantalla
    LD A, 0             ; Inicializar el registro A con 0
    OUT ($FE), A        ; Pone el borde de la pantalla en negro

    ; Mensaje de despedida
    LD A,4         ; Letra verde, fondo negro, parpadeante
    LD B,8              ; Coordenadas para pintar el título
    LD C,7       
    LD IX, Mensaje_adios ; Dirección del título
    CALL PRINTAT        ; Imprime el título

    ; Adiós
    LD A,2             ; Letra roja, fondo negro
    LD B,13             ; Coordenadas para pintar el mensaje
    LD C,13               
    LD IX, Adios         ; Dirección del mensaje
    CALL PRINTAT        ; Imprime el mensaje

    ; Créditos
    LD A,3             ; Letra rosita, fondo negro
    LD B,23            ; Coordenadas para pintar el mensaje
    LD C,3               
    LD IX, Credits      ; Dirección del mensaje
    CALL PRINTAT        ; Imprime el mensaje

    RET

Mensaje_adios: db "Gracias por jugar",0 ; Mensaje de despedida
Adios:         db "ADIOS!",0            ; Mensaje de adiós
Credits:       db "Made by: Dari,Vitto & Nia",0 ; Créditos