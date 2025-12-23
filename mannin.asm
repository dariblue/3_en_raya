        DEVICE ZXSPECTRUM48
	    SLDOPT COMMENT WPMEM, LOGPOINT, ASSETION

        ORG $8000   ; Programa ubicado en la memoria de $8000 = 32768

; Rutina de inicialización
inicio:
    DI              ; Deshabilitar interrupciones
    LD SP, 0        ; Inicializar el puntero de pila en la parte superior de la memoria
;---------------------------------------------------------------------------------------------------
; Código del estudiante
    CALL bienvenida ; Llamar a la rutina de bienvenida
    CALL tecladoS_N ; Llamar a la rutina que espera S o N
    CP 'N'          ; Comparar con 'N'
    JR Z, fin       ; Si se pulsa N, finalizar el programa

partida:
    CALL inicializar  
    CALL juego      ; Llamar a la rutina principal del juego
    CALL partida    ; Repetir la partida

fin:        
    CALL despedida
    CALL tecladoS_N ; Llamar a la rutina que espera S o N
    CP 'S'          ; Comparar con 'S'
    JR Z, partida   ; Si se pulsa S, iniciar una nueva partida

fin2:   
    CALL adios    ; Mostrar mensaje de despedida
    HALT          ; Detener el programa
;-------------------------------------------------------------------------------------------
    INCLUDE "pantalla_inicial.asm"      ; Incluir el archivo de la pantalla inicial (bienvenida)
    INCLUDE "printat.asm"               ; Incluir el archivo con la rutina PRINTAT
    INCLUDE "coord_atrib.asm"           ; Incluir el archivo con la rutina COORD_ATRIB
    INCLUDE "tecladittoS_N.asm"         ; Incluir el archivo con la rutina del tecladito S/N
    INCLUDE "soltar_tecla.asm"          ; Incluir el archivo con la rutina SOLTAR_TECLA
    INCLUDE "pantalla_final.asm"        ; Incluir el archivo de la pantalla final (despedida)
    INCLUDE "conecta4_juego.asm"        ; Incluir el archivo con la lógica del juego
    INCLUDE "cargar_juego.asm"          ; Incluir el archivo con la rutina de carga del juego
    INCLUDE "adios.asm"                 ; Incluir el archivo con el mensaje de despedida final
    INCLUDE "tecladitto_Juego.asm"      ; Incluir el archivo con la rutina del tecladito Q,W,F,ENTER
    INCLUDE "piecitta.asm"              ; Incluir el archivo con la rutina para dibujar fichas
    INCLUDE "dibujar_tablero.asm"       ; Incluir el archivo con la rutina para dibujar el tablero
    INCLUDE "movef_derecha.asm"         ; Incluir el archivo con la rutina para mover ficha a la derecha
    INCLUDE "movef_izquierda.asm"       ; Incluir el archivo con la rutina para mover ficha a la izquierda
    INCLUDE "borrar_ficha.asm"          ; Incluir el archivo con la rutina para borrar ficha
    INCLUDE "bajar_ficha.asm"           ; Incluir el archivo con la rutina para bajar la pieza
    INCLUDE "jugar_ficha.asm"           ; Incluir el archivo con la rutina para jugar la ficha   
    INCLUDE "pintar_ficha.asm"          ; Incluir el archivo con la rutina para pintar la ficha en la ruta actual
    INCLUDE "comprobar_4en_raya.asm"    ; Incluir el archivo con la rutina para comprobar que la ficha ficha haga un 4 en raya
    INCLUDE "comprobar_tablas.asm"      ; Incluir el archivo con la rutina para comprobar si el tablero está lleno
;-------------------------------------------------------------------------------------------

    