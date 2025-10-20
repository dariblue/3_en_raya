    DEVICE ZXSPECTRUM48
    SLDOPT COMMENT WPMEM, LOGPOINT, ASSETION
    ORG $8000               ; Programa ubicado a partir de $8000 = 32768

inicio:         DI              ; Deshabilitar interrupciones
    LD SP,0         ; Establecer el puntero de pila en la parte alta de la memoria
        
;-------------------------------------------------------------------------------------------------
;Código del estudiante

bucle:
    LD A, R
    OUT ($FE),A
    JR bucle

;-------------------------------------------------------------------------------------------------
fin:            JR fin          ; bucle infinito
