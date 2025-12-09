; ==============================================================================
; Rutina: comprobar_tablas
; Descripción: Verifica si el tablero está completamente lleno (Empate).
;              Se asume que se llama DESPUÉS de comprobar_ganapuerta, por lo que
;              si llegamos aquí, sabemos que nadie ha ganado todavía.
; Entrada: Ninguna
; Salida:  A = 1 (Tablas/Empate), A = 0 (Sigue jugando)
; ==============================================================================

comprobar_tablas:
    PUSH BC
    PUSH DE
    PUSH HL
    PUSH IX

    ; Estrategia: Solo necesitamos comprobar si la fila superior (Fila 1) de TODAS
    ; las columnas está ocupada. Si todas las columnas están llenas hasta arriba,
    ; es un empate.
    
    ; El tablero tiene 7 columnas (0-6).
    ; Cada columna tiene 8 bytes.
    ; La primera casilla jugable de cada columna es el byte 1 (IX+1).
    
    LD IX, Fichas   ; Inicio del tablero
    LD B, 7                 ; Contador de columnas (7 columnas)
    LD DE, 8                ; Tamaño de cada columna para saltar

.bucle_columnas:
    LD A, (IX+1)            ; Miramos la casilla superior (Fila 1)
    OR A                    ; ¿Es 0 (Vacío)?
    JR Z, .hay_hueco        ; Si encontramos UN solo 0, NO es tablas.

    ADD IX, DE              ; Saltar a la siguiente columna (+8 bytes)
    DJNZ .bucle_columnas    ; Repetir para las 7 columnas

    ; Si el bucle termina, significa que NO encontró ningún 0 en la fila superior.
    ; ¡TABLAS!
    POP IX
    POP HL
    POP DE
    POP BC
    JP fin                  ; Saltar directamente al bucle de despedida


.hay_hueco:
    ; Encontramos al menos una columna con espacio. Sigue el juego.
    POP IX
    POP HL
    POP DE
    POP BC
    LD A, 0                 ; Retornar 0 (Sigue jugando)
    RET
