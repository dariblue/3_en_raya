        DEVICE ZXSPECTRUM48
        SLDOPT COMMENT WPMEM, LOGPOINT, ASSENTION

        ORG $8000   ; Programa ubicado en la memoria de $8000 = 32768

; Rutina de inicialización
inicio:
    DI              ; Deshabilitar interrupciones
    LD SP, 0        ; Inicializar el puntero de pila en la parte superior de la memoria
;---------------------------------------------------------------------------------------------------
; Código del estudiante
    CALL bienvenida       ; Llamar a la rutina de bienvenida (pantalla_inicial.asm)
    CALL tecladoS_N       ; Llamar a la rutina para leer S/N (tecladittoS_N.asm)
    CP 'N'                ; Comparar con 'N'
    JR Z, fin             ; Si se pulsa N, finalizar el programa

partida:
    CALL inicializar      ; Inicializar el juego (cargar_juego.asm)
    CALL juego            ; Llamar a la rutina principal del juego (conecta4_juego.asm)
    JP partida            ; Repetir la partida

fin: 
    CALL despedida        ; Llamar a la rutina de despedida (pantalla_final.asm)
    CALL tecladoS_N       ; Llamar a la rutina que espera S o N (tecladittoS_N.asm)
    CP 'S'                ; Comparar con 'S'
    JR Z, partida         ; Si se pulsa S, iniciar una nueva partida  

fin2:   
    CALL adios            ; Mostrar mensaje de despedida (pantalla_adios.asm)
    HALT                  ; Detener el programa

;---------------------------------------------------------------------------------------------------
    INCLUDE "pantalla_inicial.asm"    ; Incluir rutina de pantalla inicial (bienvenida)
    INCLUDE "pantalla_final.asm"      ; Incluir rutina de pantalla final (despedida)
    INCLUDE "pantalla_adios.asm"      ; Incluir rutina de pantalla de adiós 
    INCLUDE "printat.asm"             ; Incluir rutina PRINTAT
    INCLUDE "tecladittoS_N.asm"       ; Incluir rutina para leer teclado S/N
    INCLUDE "soltar_tecla.asm"        ; Incluir rutina para soltar tecla
    INCLUDE "coord_atrib.asm"         ; Incluir rutina para calcular dirección de atributos
    INCLUDE "cargar_juego.asm"        ; Incluir rutina de carga e inicialización del juego
    INCLUDE "conecta4_juego.asm"      ; Incluir rutina principal del juego Conecta 4
    INCLUDE "piecitta.asm"            ; Incluir rutina para pintar fichas
    INCLUDE "tecladitto_juego.asm"    ; Incluir rutina para leer teclado durante el juego
    INCLUDE "movimiento_piecitta.asm" ; Incluir rutina para mover ficha
    INCLUDE "borrar_ficha.asm"        ; Incluir rutina para borrar ficha
    INCLUDE "bajar_ficha.asm"         ; Incluir rutina para bajar ficha
    INCLUDE "retardittos.asm"         ; Incluir rutina para retardo breve
    INCLUDE "cambio_turno.asm"        ; Incluir rutina para cambiar turno
    INCLUDE "resetear_variables.asm"  ; Incluir rutina para resetear variables y tablero
    INCLUDE "comprobar_4en_raya.asm"  ; Incluir rutina para comprobar 4 en raya
    INCLUDE "comprobar_tablas.asm"    ; Incluir rutina para comprobar tablas
    INCLUDE "victoria.asm"            ; Incluir rutina de victoria
    INCLUDE "empate.asm"              ; Incluir rutina de empate
;---------------------------------------------------------------------------------------------------

