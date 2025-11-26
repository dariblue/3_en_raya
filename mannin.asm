        DEVICE ZXSPECTRUM48
	SLDOPT COMMENT WPMEM, LOGPOINT, ASSETION
        ORG $8000               ; Programa ubicado a partir de $8000 = 32768

inicio:     
        DI              ; Deshabilitar interrupciones
        LD SP,0         ; Establecer el puntero de pila en la parte alta de la memoria
        
;-------------------------------------------------------------------------------------------------
;Código del estudiante

        CALL bienvenida        ; Llamar a la rutina de bienvenida
        CALL tecladoS_N        ; Esperar tecla S o N
        CP 'N'                 ; Comparar con 'N'
        JR Z, fin              ; Si se pulsa N, finalizar el programa

partida:
        CALL inicializar       ; Llamar a la rutina de inicialización
        CALL juego
        CALL tecladoS_N     ; Esperar tecla S o N
        CP 'S'                 ; Comparar con 'S'
        JR Z, partida         ; Si se pulsa S, iniciar5 una nueva partida
        
;-------------------------------------------------------------------------------------------------
fin:        
        call despedida

fin2:   JR fin2          ; bucle infinito

        INCLUDE "bienvenida.asm"  ; Incluir el código de bienvenida
        INCLUDE "inicializar.asm" ; Incluir el código de inicialización
        INCLUDE "conecta4_juego.asm" ; Incluir el código del juego
        INCLUDE "tecladittoS_N.asm"  ; Incluir el código de espera de tecla S o N
        INCLUDE "tecladittoQW_INT_F.asm"  ; Incluir el código de espera de tecla Q, W, INTRO, F
        INCLUDE "pantalla_final.asm"  ; Incluir el código de despedida
        INCLUDE "printat.asm"         ; Incluir el código de PRINTAT
        INCLUDE "soltar_tecla.asm"    ; Incluir el código de SOLTAR_TECLA
        INCLUDE "coord_atrib.asm"      ; Incluir el código de CORD_ATRIB
        INCLUDE "piececitta.asm"       ; Incluir el código de PIECECITA
        INCLUDE "bajar_piececitta.asm" ; Incluir el código de BAJAR_PIECECITA

        

