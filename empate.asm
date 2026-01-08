empatesitto:
    CALL CLEARSCR   ; Borrar pantalla
    LD A, 0         ; Inicializar el registro A con 0
    OUT ($FE), A    ; Pone el borde de la pantalla en negro

    ; Pintar la pantalla de victoria
    LD HL, fEmpatte       ; Dirección del bucle que pinta la pantalla
    LD DE, $4000    
    LD BC, $5B00 - $4000 
    LDIR  

    ; Mensaje final tras empate
    LD A,16          ; Letra azulita, fondo negro
    LD B,20       ; Coordenadas para pintar el mensaje
    LD C,2       
    LD IX, Mensaje_final_empate   ; Dirección del mensaje
    CALL PRINTAT    ; Imprime el mensaje       

;--------------------------------------------------------------------------------------
fEmpatte: INCBIN "empate2.scr"
Mensaje_final_empate:   db "Quieres jugar de nuevo (S/N)?",0   ; Mensaje final