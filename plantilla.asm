        DEVICE ZXSPECTRUM48
	SLDOPT COMMENT WPMEM, LOGPOINT, ASSETION
        org $8000               ; Programa ubicado a partir de $8000 = 32768

inicio:         di              ; Deshabilitar interrupciones
                ld sp,0         ; Establecer el puntero de pila en la parte alta de la memoria
        
;-------------------------------------------------------------------------------------------------
;Código del estudiante

bucle:
        ld a, r
        out ($fe),a
        jr bucle

;-------------------------------------------------------------------------------------------------
fin:            jr fin          ; Bucle infinito
