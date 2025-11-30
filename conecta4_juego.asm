; Rutina de juego
juego:
    CALL drawBoard
    JP JugarFicha         ; Entrar en el bucle principal del juego

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

; --- NUEVA RUTINA PRINCIPAL: JugarFicha ---
JugarFicha:
    ; 1. Pintar ficha en posición actual
    LD A, (ficha_fila)
    LD H, A
    LD A, (ficha_columna)
    LD L, A
    LD A, (color_jugador)
    LD D, A
    CALL dibujar_ficha

    ; 2. Leer Teclado (Devuelve A: -1, 0, 1, $FE)
    CALL LeerTeclado

    ; 3. Evaluar Acción
    CP $FE
    JP Z, fin_juego     ; F -> Fin

    CP 0
    JP Z, BajarFicha    ; 0 -> Bajar

    CP 1
    JR Z, mover_derecha ; 1 -> Derecha

    ; Si llega aquí es -1 ($FF) -> Izquierda
mover_izquierda:
    LD A, L
    CP COLUMNA_INICIAL
    JR Z, JugarFicha    ; Tope izquierdo, ignorar

    CALL borrar_ficha   ; Borrar en posición vieja
    LD A, L
    SUB 4               ; Mover 4 pixels a la izquierda
    LD L, A
    LD (ficha_columna), A
    JR JugarFicha

mover_derecha:
    LD A, L
    CP COLUMNA_MAXIMA
    JR Z, JugarFicha    ; Tope derecho, ignorar

    CALL borrar_ficha   ; Borrar en posición vieja
    LD A, L
    ADD 4               ; Mover 4 pixels a la derecha
    LD L, A
    LD (ficha_columna), A
    JR JugarFicha

; --- RUTINA DE BAJADA Y LÓGICA ---
BajarFicha:
    ; 1. Calcular columna lógica y puntero IX
    LD A, (ficha_columna)
    SUB 2
    SRL A
    SRL A               ; /4 -> Índice 0-6
    LD C, A
    
    LD HL, tablero_logico
    LD B, 0
    ; BC = C * 7
    LD A, C
    ADD A, A            ; x2
    ADD A, C            ; x3
    ADD A, A            ; x6
    ADD A, C            ; x7
    LD C, A
    ADD HL, BC
    PUSH HL
    POP IX              ; IX apunta al inicio de columna (Fila 0)
    
    ; 2. Verificar si la columna está llena (Fila 0 ocupada)
    LD A, (IX+0)
    OR A
    JP NZ, JugarFicha   ; Columna llena, volver a control

    ; 3. Primer paso: Caer de Preview (H=2) a Tablero (H=5)
    LD H, 2
    LD A, (ficha_columna)
    LD L, A
    CALL borrar_ficha
    
    INC H
    INC H
    INC H               ; H=5 (Fila 0 Visual)
    
    LD A, (color_jugador)
    LD D, A
    CALL dibujar_ficha
    CALL pausa_breve

    ; 4. Bucle de Caída
bucle_caida:
    ; Verificar siguiente casilla lógica (IX+1)
    LD A, (IX+1)
    OR A
    JR NZ, colision     ; Si no es 0 (Ficha o Suelo), paramos

    ; Bajar un paso
    CALL borrar_ficha
    INC H
    INC H
    INC H               ; +3 filas visuales
    INC IX              ; +1 fila lógica
    
    LD A, (color_jugador)
    LD D, A
    CALL dibujar_ficha
    CALL pausa_breve
    JR bucle_caida

colision:
    ; 5. Fijar ficha en memoria (IX apunta a la casilla libre donde estamos)
    LD A, (color_jugador)
    CP COLOR_JUGADOR_1
    JR NZ, guardar_j2
    
    LD (IX+0), 1        ; Guardar 1 para Rojo
    JR cambio_turno

guardar_j2:
    LD (IX+0), 2        ; Guardar 2 para Amarillo

cambio_turno:
    LD A, (color_jugador)
    CP COLOR_JUGADOR_1
    JR Z, set_j2
    
    LD A, COLOR_JUGADOR_1
    LD (color_jugador), A
    JR reset_pos

set_j2:
    LD A, COLOR_JUGADOR_2
    LD (color_jugador), A

reset_pos:
    ; Resetear posición visual arriba para el siguiente turno
    LD A, 2
    LD (ficha_fila), A
    JP JugarFicha

pausa_breve:
    PUSH BC
    LD B, 2
p_loop:
    PUSH BC
    LD BC, $1000
d_loop:
    DEC BC
    LD A, B
    OR C
    JR NZ, d_loop
    POP BC
    DJNZ p_loop
    POP BC
    RET

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

; Tablero Lógico (7 columnas x 7 filas)
; 0 = Vacío, 1 = Jugador 1, 2 = Jugador 2, $FF = Suelo/Tope
tablero_logico:
    DB 0, 0, 0, 0, 0, 0, $FF    ; Columna 0
    DB 0, 0, 0, 0, 0, 0, $FF    ; Columna 1
    DB 0, 0, 0, 0, 0, 0, $FF    ; Columna 2
    DB 0, 0, 0, 0, 0, 0, $FF    ; Columna 3
    DB 0, 0, 0, 0, 0, 0, $FF    ; Columna 4
    DB 0, 0, 0, 0, 0, 0, $FF    ; Columna 5
    DB 0, 0, 0, 0, 0, 0, $FF    ; Columna 6

; Etiqueta del recurso binario del tablero (archivo .scr)
tablerito: INCBIN "tablerito.scr"

