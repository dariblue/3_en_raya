; Rutina de juego
Juego: 

        LD HL, tablerito
        LD DE, $4000
        LD BC, $5B00 - $4000
        LDIR
        HALT

tablerito: INCBIN "tablerito.scr"