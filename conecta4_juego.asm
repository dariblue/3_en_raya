juego:
    LD A, 0             
    LD A, (ficha_columna)
    LD L, A                 ; L = Columna Lógica (0-6)

turno:
    LD A, (ficha_columna)   ; Recargar columna actual (necesario tras cambio de turno)
    LD L, A
    CALL pintar_ficha       ; Pinta en (ficha_columna) fila 2 (piecitta.asm)
    CALL tecladitto         ; Lee tecla de movimiento o confirmación (tecladitto_juego.asm)
    CP $FE
    JP Z, final_forzoso               ; Si es código de fin, terminar juego
    
    OR A
    JP Z, secuencia_bajar   ; Si A=0, bajar ficha

    CALL mover_piecitta     ; Mover ficha izquierda/derecha (movimiento_piecitta.asm)

    JP turno

secuencia_bajar:
    CALL bajar_ficha        
    JR NZ, turno          

    ; Si se puede bajar, borramos la ficha de la parte superior (preview)
    CALL borrar_ficha_actual

    CALL preparar_coordenadas_caida

    ; Pintar inicial
    LD A, (color_jugador)
    LD D, A
    CALL dibujar_ficha
    CALL pausa_breve
    
    INC IX

bucle_caida_loop:
    CALL verificar_siguiente_casilla
    JR NZ, fin_caida_loop

    ; Borrar ficha (usando dibujar_ficha con color 0 para evitar call anidado)
    CALL borrar_ficha

    CALL avanzar_posicion
    
    LD A, (color_jugador)
    LD D, A
    CALL dibujar_ficha
    CALL pausa_breve
    
    JR bucle_caida_loop

fin_caida_loop:
    CALL finalizar_turno_caida
    CALL cambio_turnitto

    ;Comprobar victoria/tablas
    CALL comprobar_ganapuerta ; Comprobar si hay 4 en raya tras el movimiento
    CP 1
    JR Z, hay_ganapuerta

    CALL comprobar_tablas
    CP 1
    JR Z, hay_empatesitto

    JP turno

hay_ganapuerta:
    CALL victoria      ; Mostrar mensaje de ganador (printat.asm)
    CALL tecladoS_N       ; Llamar a la rutina que espera S o N (tecladittoS_N.asm)
    CP 'S'                ; Comparar con 'S'
    JR Z, newgame         ; Si se pulsa S, iniciar una nueva partida  
    JP fin2                ; Si no, finalizar el programa

hay_empatesitto
    CALL empatesitto      ; Mostrar mensaje de ganador (printat.asm)
    CALL tecladoS_N       ; Llamar a la rutina que espera S o N (tecladittoS_N.asm)
    CP 'S'                ; Comparar con 'S'
    JR Z, newgame         ; Si se pulsa S, iniciar una nueva partida  
    JP fin2                ; Si no, finalizar el programa

newgame:   
    CALL limpiar_memoria_jueguitto ; Resetear variables y tablero -> resetera_variables.asm
    JP partida

final_forzoso:
    CALL limpiar_memoria_jueguitto ; Resetear variables y tablero -> resetera_variables.asm
    JP fin