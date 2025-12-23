; ==============================================================================
; Rutina: adios
; Entrada: Ninguna
; Salida: Muestra el mensaje de despedida en pantalla
; Datos del programa: Mensaje_adios, Adios
; ==============================================================================

adios:
; Rutina para mostrar el mensaje de despedida final
    CALL CLEARSCR       ; Borrar pantalla
    LD A, 0             ; Inicializar el registro A con 0
    OUT ($FE), A        ; Pone el borde de la pantalla en negro

    ; Mensaje de despedida
    LD A,4         ; Letra moradita, fondo negro, parpadeante
    LD B,8              ; Coordenadas para pintar el título
    LD C,7       
    LD IX,Mensaje_adios ; Dirección del título
    CALL PRINTAT        ; Imprime el título

    ; Adiós
    LD A,2             ; Letra azulita, fondo negro
    LD B,13             ; Coordenadas para pintar el mensaje
    LD C,13               
    LD IX,Adios         ; Dirección del mensaje
    CALL PRINTAT        ; Imprime el mensaje

    RET

Mensaje_adios: db "Gracias por jugar",0 ; Mensaje de despedida
Adios:         db "ADIOS!",0            ; Mensaje de despedida