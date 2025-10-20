    DEVICE ZXSPECTRUM48
	SLDOPT COMMENT WPMEM, LOGPOINT, ASSETION
        ORG $8000               ; Programa ubicado a partir de $8000 = 32768

inicio:         DI              ; Deshabilitar interrupciones
                LD SP,0         ; Establecer el puntero de pila en la parte alta de la memoria
        
;-------------------------------------------------------------------------------------------------
;Código del estudiante

INCLUDE "bienvenida.asm"  ; Incluir el código de bienvenida

    CALL Bienvenida  ; Llamar a la rutina de bienvenida

;-------------------------------------------------------------------------------------------------
fin:            JR fin          ; bucle infinito
