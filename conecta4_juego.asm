; Rutina de juego
juego:
    CALL drawBoard
    CALL gameLoop         ; Entrar en el bucle principal del juego
    RET

; Dibuja el tablero inicial (tablerito.scr) y la ficha del jugador activo
drawBoard:
    LD HL, tablerito 
    LD DE, $4000  ; Dirección de pantalla en ZX Spectrum
    LD BC, $5B00 - $4000    ; tamaño: $5B00 - $4000 = $1B00 (6912 bytes) tamaño pantalla ZX Spectrum
    LDIR 
    
    ; Pintar ficha inicial del jugador activo encima de la primera columna
    ; Coordenadas: Fila 2, Columna inicial (Ajustado para pegar al tablero)
    LD H, 2                 ; Fila 2
    LD L, COLUMNA_INICIAL   ; Columna inicial
    
    ; Guardar la posición inicial
    LD A, H
    LD (ficha_fila), A
    LD A, L
    LD (ficha_columna), A
    
    LD D, COLOR_JUGADOR_1   ; Color del jugador 1 (rojo)
    CALL dibujar_ficha
    RET
    
    ; TODO: Modificar para que el color venga en D

; Bucle principal: espera tecla, cambia jugador y repinta la ficha
gameLoop:
    CALL tecladoQW_INT_F  ; Leer tecla pulsada (Devuelve en A: 'Q', 'W', 'E', 'F')
    
    ; Verificar qué tecla se pulsó
    CP 'W'
    JP Z, mover_dcha      ; Si es W, mover a la derecha (JP para evitar error de rango)
    
    CP 'Q'
    JP Z, mover_izq       ; Si es Q, mover a la izquierda
    
    CP 'E'                ; Enter
    JP Z, cambiar_jugador_y_soltar
    
    CP 'F'                ; F para finalizar
    JP Z, fin_juego
    
    JP gameLoop           ; Continuar el bucle

cambiar_jugador_y_soltar:
    ; 1. Calcular índice de columna lógica (0-6)
    ; Fórmula: (ficha_columna - 2) / 4
    LD A, (ficha_columna)
    SUB 2
    SRL A               ; Dividir por 2
    SRL A               ; Dividir por 2 (Total: /4)
    LD C, A             ; C = Índice de columna (0-6)

    ; 2. Calcular dirección base de la columna en tablero_logico
    ; Dirección = tablero_logico + (Columna * 6)
    LD HL, tablero_logico
    LD B, 0
    
    ; Multiplicar C * 6 (6 filas por columna)
    LD A, C
    ADD A, C            ; A = C*2
    ADD A, C            ; A = C*3
    ADD A, A            ; A = C*6
    
    LD C, A
    ADD HL, BC          ; HL apunta ahora al inicio de la columna en memoria lógica
    PUSH HL
    POP IX              ; IX = Puntero a la celda actual en lógica

    ; 3. Verificar si la columna está llena (la primera celda ya está ocupada)
    LD A, (IX+0)
    CP 0
    JP NZ, gameLoop     ; Si está llena, ignorar pulsación

    ; --- INICIALIZAR COORDENADAS VISUALES ---
    LD H, 2                 ; Empezamos en la fila visual 2
    LD A, (ficha_columna)
    LD L, A                 ; Cargamos la columna visual actual

    ; 4. Bucle de Caída (Gravedad)
caida_loop:
    ; Verificar si hemos llegado al fondo
    ; Fila visual inicial = 2
    ; Salto por fila = 3 (2 de ficha + 1 de borde)
    ; Fila 0: 2
    ; Fila 1: 5
    ; Fila 2: 8
    ; Fila 3: 11
    ; Fila 4: 14
    ; Fila 5: 17 (Fondo)
    
    LD A, H
    CP 17               ; Fila visual máxima ajustada
    JR Z, fijar_ficha   ; Si estamos abajo del todo, fijar
    
    ; Mirar si la casilla lógica de abajo está ocupada
    LD A, (IX+1)
    CP 0
    JR NZ, fijar_ficha  ; Si hay algo abajo, fijar

    ; --- ANIMACIÓN DE BAJADA ---
    
    ; A. Borrar ficha actual
    CALL borrar_ficha
    
    ; B. Bajar visualmente (Salto de 3 filas para saltar el borde)
    INC H
    INC H
    INC H               ; Bajamos 3 filas (2 ficha + 1 borde)
    
    ; C. Bajar lógicamente
    INC IX              ; Avanzamos al siguiente byte en el array
    
    ; D. Pintar en nueva posición
    LD D, COLOR_JUGADOR_1 ; TODO: Usar variable dinámica
    LD A, (color_jugador)
    LD D, A
    CALL dibujar_ficha
    
    ; E. Pausa para ver la animación
    PUSH BC
    LD B, 2             ; Reducimos las repeticiones
pausa_caida:
    PUSH BC
    LD BC, $1000        ; Reducimos el contador de retardo
bucle_retardo:
    DEC BC
    LD A, B
    OR C
    JR NZ, bucle_retardo
    POP BC
    DJNZ pausa_caida
    POP BC
    
    JR caida_loop       ; Repetir

fijar_ficha:
    ; Marcar en el tablero lógico que esta casilla está ocupada
    LD A, (color_jugador) ; Usamos el color como ID de jugador ($10 o $30)
    LD (IX+0), A
    
    ; Cambiar de turno
    LD A, (color_jugador)
    CP COLOR_JUGADOR_1
    JR Z, poner_jugador_2
    
    ; Poner Jugador 1
    LD A, COLOR_JUGADOR_1
    LD (color_jugador), A
    JR reset_ficha_arriba

poner_jugador_2:
    LD A, COLOR_JUGADOR_2
    LD (color_jugador), A

reset_ficha_arriba:
    ; Crear nueva ficha arriba para el siguiente turno
    LD H, 2
    LD A, (ficha_columna)
    LD L, A
    LD A, (color_jugador)
    LD D, A
    CALL dibujar_ficha
    
    JP gameLoop

mover_dcha:
    ; 1. Cargar posición actual
    LD A, (ficha_fila)
    LD H, A
    LD A, (ficha_columna)
    LD L, A
    
    ; 2. Verificar límite derecho
    LD A, L
    CP COLUMNA_MAXIMA   ; ¿Estamos en la última columna?
    JP Z, gameLoop      ; Si sí, volver sin hacer nada
    
    ; 3. BORRAR ficha actual (Pintar de negro)
    CALL borrar_ficha
    
    ; 4. Calcular nueva posición
    LD A, (ficha_columna)
    ADD A, COLUMNA_INCREMENTO
    LD (ficha_columna), A   ; Guardar nueva columna
    LD L, A                 ; Actualizar L para pintar
    
    ; 5. PINTAR ficha nueva (Color del jugador)
    LD H, 2                 ; Fila siempre 2
    LD A, (color_jugador)
    LD D, A                 ; Usar color del jugador activo
    CALL dibujar_ficha
    
    JP gameLoop

mover_izq:
    ; 1. Cargar posición actual
    LD A, (ficha_fila)
    LD H, A
    LD A, (ficha_columna)
    LD L, A
    
    ; 2. Verificar límite izquierdo
    LD A, L
    CP COLUMNA_INICIAL  ; ¿Estamos en la primera columna?
    JP Z, gameLoop      ; Si sí, volver sin hacer nada
    
    ; 3. BORRAR ficha actual
    CALL borrar_ficha
    
    ; 4. Calcular nueva posición
    LD A, (ficha_columna)
    SUB COLUMNA_INCREMENTO
    LD (ficha_columna), A   ; Guardar nueva columna
    LD L, A                 ; Actualizar L para pintar
    
    ; 5. PINTAR ficha nueva
    LD H, 2
    LD A, (color_jugador)
    LD D, A
    CALL dibujar_ficha
    
    JP gameLoop

borrar_ficha:
    LD D, 0             ; Color 0 (Negro/Borrar)
    CALL dibujar_ficha
    RET

fin_juego:
    CALL CLEARSCR   ; Borrar pantalla
    CALL despedida
    ;TODO Pintar bien la piececita segun el jugador activo (color en D)

; Constantes para el tablero
COLUMNA_INICIAL     EQU 2       ; Primera columna del tablero
COLUMNA_INCREMENTO  EQU 4       ; Incremento entre columnas (3 de ficha + 1 de borde)
COLUMNA_MAXIMA      EQU COLUMNA_INICIAL + (6 * COLUMNA_INCREMENTO)  ; Última columna (7 columnas: 0-6)

; Constantes de color
COLOR_JUGADOR_1     EQU $10     ; Color rojo para jugador 1
COLOR_JUGADOR_2     EQU $30     ; Color amarillo para jugador 2
COLOR_FONDO         EQU $07     ; Color de fondo del tablero (blanco sobre negro)

; Variables para la posición de la ficha
ficha_fila:    DB 0
ficha_columna: DB 0
color_jugador: DB $10   ; Jugador actual ($10 = Rojo, $30 = Amarillo)

; Tablero Lógico (7 columnas x 6 filas = 42 bytes)
; Se organiza por columnas: Col 0 (6 bytes), Col 1 (6 bytes)...
; 0 = Vacío, $10 = Jugador 1, $30 = Jugador 2
tablero_logico: DS 42, 0

; Etiqueta del recurso binario del tablero (archivo .scr)
tablerito: INCBIN "tablerito.scr"



