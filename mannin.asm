        DEVICE ZXSPECTRUM48
	    SLDOPT COMMENT WPMEM, LOGPOINT, ASSETION
        ORG $8000               ; Programa ubicado a partir de $8000 = 32768

inicio:     DI              ; Deshabilitar interrupciones
            LD SP,0         ; Establecer el puntero de pila en la parte alta de la memoria
        
;-------------------------------------------------------------------------------------------------
;Código del estudiante

    INCLUDE "bienvenida.asm"  ; Incluir el código de bienvenida
    INCLUDE "pantalla_final.asm" ; Incluir el código de despedida
    INCLUDE "printat.asm"         ; Incluir el código de PRINTAT
    INCLUDE "pantalla_de_juego.asm" ; Incluir el código de la pantalla de juego
    

            CALL Bienvenida
;-------------------------------------------------------------------------------------------------
fin:        JR fin          ; bucle infinito
