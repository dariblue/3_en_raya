; ==============================================================================
; Rutina: victoria
; Entrada: Ninguna
; Salida: Muestra la pantalla de título
; Datos del programa: elreal.scr, Titulo, Mensaje
; ==============================================================================

victoria:
    CALL CLEARSCR   ; Borrar pantalla
    LD A, 0         ; Inicializar el registro A con 0
    OUT ($FE), A    ; Pone el borde de la pantalla en negro

    ; Pintar la pantalla de victoria
    LD HL, XD2       ; Dirección del bucle que pinta la pantalla
    LD DE, $4000    
    LD BC, $5B00 - $4000 
    LDIR          

    ; Mensaje de victoria
    LD A, (ganadora)          ; Letra color ganador, fondo azul
    LD B,12         ; Coordenadas (filas) para pintar el mensaje
    LD C,5          ; Coordenadas (columnas) para pintar el mensaje (ajustado para centrar)
    
    
    ; Seleccionar mensaje según ganador
    CP $0A          ; ¿Es Rojo (Jugador 1)?
    JR Z, msg_j1
    
    LD IX, MsgJ2    ; Si no es Rojo, es Amarillo (Jugador 2)
    JR imprimir_msg


msg_j1:
    LD IX, MsgJ1

imprimir_msg:
    CALL PRINTAT    ; Imprime el mensaje

    ; Mensaje final tras ganar
    LD A,11          ; Letra azulita, fondo negro
    LD B,21       ; Coordenadas para pintar el mensaje
    LD C,2       
    LD IX,Mensaje_final_ganar   ; Dirección del mensaje
    CALL PRINTAT    ; Imprime el mensaje



;-------------------------------------------------------------------------------------
XD2: INCBIN "vctoria.scr"
MsgJ1: db "Jugador 1 ha ganado!!",0
MsgJ2: db "Jugador 2 ha ganado!!",0
Mensaje_final_ganar:   db "Quieres jugar de nuevo (S/N)?",0   ; Mensaje 