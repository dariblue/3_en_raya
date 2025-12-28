; ==============================================================================
; Rutina: jugar_ficha
; Entrada: ficha_columna
; Salida: Gestiona el movimiento lateral y la bajada de la ficha
; Datos del programa: COLUMNA_INICIAL
; ==============================================================================

jugar_ficha:
    LD A, 0
    LD A, (ficha_columna)
    LD L, A                 ; L = Columna Lógica (0-6)

JF2:
    CALL pintar_ficha        ; Pinta la ficha en la posición actual (L)

    CALL teclado_Juego        ; Devuelve A: -1, 0, 1, $FE
    
    CP $FE            ; Comprobar si es ENTER
    JP Z, fin         ; Salida de emergencia

    OR A                    ; Comprobar si es 0 (Bajar)
    JP Z, bajar_ficha        ; Si A=0, saltar a lógica de caída (JF1)

    ; A tiene la dirección (-1 o 1)
    ; L tiene la posición actual
    
    ADD A, L                ; A = Nueva Posición (Candidata)
    
    PUSH AF                 ; Guardamos la nueva posición
    
    CALL borrar_ficha_preview ; Borramos ficha en posición actual (L)

    POP AF                  ; Recuperamos la nueva posición
    
    CP 7                    ; Validar (0 <= A < 7)
    JR NC, JF2              ; Si es inválido (>=7 o negativo), repetir bucle (L no cambia)
    
    LD L, A                 ; Si es válido, actualizar L
    LD (ficha_columna), A   ; Actualizar 
    JR JF2                  ; Repetir bucle