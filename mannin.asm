        DEVICE ZXSPECTRUM48
	    SLDOPT COMMENT WPMEM, LOGPOINT, ASSETION
        ORG $8000               ; Programa ubicado a partir de $8000 = 32768

inicio:     DI              ; Deshabilitar interrupciones
            LD SP,0         ; Establecer el puntero de pila en la parte alta de la memoria
        
;-------------------------------------------------------------------------------------------------
;Código del estudiante

            CALL Bienvenida        ; Llamar a la rutina de bienvenida

;-------------------------------------------------------------------------------------------------
fin:        JR fin          ; bucle infinito

        INCLUDE "bienvenida.asm"  ; Incluir el código de bienvenida
        INCLUDE "inicializar.asm" ; Incluir el código de inicialización
        INCLUDE "tecladitto.asm"    ; Incluir el código del tecladito
        INCLUDE "pantalla_final.asm" ; Incluir el código de despedida
        INCLUDE "printat.asm"         ; Incluir el código de PRINTAT
        INCLUDE "pantalla_de_juego.asm" ; Incluir el código de la pantalla de juego
