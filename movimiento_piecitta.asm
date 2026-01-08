mover_piecitta:
    ADD A, L                ; A = Nueva Posición (Candidata)
    
    PUSH AF                 ; Guardamos la nueva posición
    ; Calcular coordenadas visuales para borrar
    PUSH HL                 ; Guardamos L (lógica)
    LD A, L
    ADD A, A
    ADD A, A
    ADD A, COLUMNA_INICIAL
    LD L, A
    LD H, 2
    CALL borrar_ficha       ; Borramos (ahora genérico)
    POP HL                  ; Recuperamos L (lógica)
    POP AF                  ; Recuperamos la nueva posición
    
    CP 7                    ; Validar (0 <= A < 7)
    JP NC, turno              ; Si es inválido (>=7 o negativo), repetir bucle (L no cambia)
    
    LD L, A                 ; Si es válido, actualizar L
    LD (ficha_columna), A   ; Actualizar memoria

    RET