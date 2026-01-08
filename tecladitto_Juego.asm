tecladitto:
    PUSH BC             ; BC al stack para preservar su valor

teclado_loop_check:
    ; Verificar jugador actual
    LD A, (color_jugador)
    CP $10              ; ¿Es Jugador 1 (Rojo)?
    JR Z, check_j1

    ;---JUGADOR 2(Amarillo)---
    ; O (Izquierda)
    LD BC,$DFFE
    IN A,(C)
    BIT 1,A
    JR Z, ret_izq       ; Pulsado O -> Izquierda

    ; P (Derecha)
    LD BC,$DFFE
    IN A,(C)
    BIT 0,A
    JR Z, ret_dcha      ; Pulsado P -> Derecha

    ; L (Bajar)
    LD BC,$BFFE
    IN A,(C)
    BIT 1,A
    JR Z, ret_bajar     ; Pulsado L -> Bajar

    JR check_fin        ; Comprobar F

check_j1:
    ;---JUGADOR 1(Rojo)---
    ; Q (Izquierda)
    LD BC,$FBFE         
    IN A,(C)
    BIT 0,A
    JR Z, ret_izq       ; Pulsado Q -> Izquierda

    ; W (Derecha)
    LD BC,$FBFE         
    IN A,(C)
    BIT 1,A
    JR Z, ret_dcha      ; Pulsado W -> Derecha

    ; S (Bajar)
    LD BC,$FDFE
    IN A,(C)
    BIT 1,A
    JR Z, ret_bajar     ; Pulsado S -> Bajar

check_fin:
    ; F (Fin) - Global
    LD BC,$FDFE
    IN A,(C)
    BIT 3,A
    JR Z, ret_fin

    JR teclado_loop_check ; Esperar hasta que se pulse algo

ret_izq:
    LD A, $FF           ; Guarda el valor -1 en A
    JR T_SALIDA
ret_dcha:
    LD A, 1             ; Guarda el valor +1 en A
    JR T_SALIDA
ret_bajar:
    LD A, 0             ; Guarda el valor 0 en A
    JR T_SALIDA
ret_fin:
    LD A, $FE           ; Código de fin
    JR T_SALIDA

T_SALIDA:
    PUSH AF             ; Guardar resultado
    CALL soltar_tecla   ; Esperar a soltar
    POP AF              ; Recuperar resultado
    POP BC              ; Recuperar BC
    RET
