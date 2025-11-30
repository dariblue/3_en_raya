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
    
    ; Inicializar ficha en columna lógica 0
    LD A, 0
    LD (ficha_columna), A   ; Guardamos índice lógico (0-6)
    LD (ficha_fila), A      ; (No se usa realmente para lógica, pero limpiamos)
    
    ; Pintar ficha inicial
    ; Calculo visual inline: (A * 4) + COLUMNA_INICIAL
    ADD A, A
    ADD A, A
    ADD A, COLUMNA_INICIAL
    LD L, A
    LD H, 2
    LD D, COLOR_JUGADOR_1
    CALL dibujar_ficha
    RET

; --- NUEVA RUTINA PRINCIPAL: JugarFicha (Adaptada a Pizarra) ---
JugarFicha:
    LD A, (ficha_columna)
    LD L, A                 ; L = Columna Lógica (0-6)

JF2:
    ; 1. Pintar Ficha (Necesitamos convertir L lógico a visual)
    PUSH HL                 ; Guardar L lógico
    LD A, L
    ; Calculo visual inline
    ADD A, A
    ADD A, A
    ADD A, COLUMNA_INICIAL
    LD L, A
    LD H, 2
    LD A, (color_jugador)
    LD D, A
    CALL dibujar_ficha
    POP HL                  ; Recuperar L lógico

    ; 2. Leer Teclado
    CALL LeerTeclado        ; Devuelve A: -1, 0, 1, $FE

    ; 3. Evaluar
    CP $FE
    JP Z, fin_juego         ; Salida de emergencia

    OR A                    ; Comprobar si es 0 (Bajar)
    JP Z, BajarFicha        ; Si A=0, saltar a lógica de caída (JF1)

    ; 4. Movimiento Lateral
    PUSH AF                 ; Guardar dirección (-1 o 1)
    
    ; Borrar ficha en posición actual (antes de mover)
    PUSH HL
    LD A, L
    ; Calculo visual inline
    ADD A, A
    ADD A, A
    ADD A, COLUMNA_INICIAL
    LD L, A
    LD H, 2
    CALL borrar_ficha
    POP HL

    POP AF                  ; Recuperar dirección
    
    ; 5. Calcular nueva posición
    ADD A, L                ; A = L + Dirección
    
    ; 6. Validar Límites (Truco de la pizarra)
    ; Si A < 7 -> Carry Set (Válido)
    ; Si A >= 7 (o negativo underflow 255) -> Carry Clear (Inválido)
    CP 7
    JR NC, JF2              ; Si no hay carry (inválido), repetir bucle (repinta en sitio viejo)

    ; 7. Actualizar posición
    LD L, A                 ; L = Nueva columna válida
    LD (ficha_columna), A   ; Guardar en memoria
    JR JF2                  ; Repetir bucle

; --- RUTINA DE BAJADA Y LÓGICA ---
BajarFicha:
    ; 1. Calcular puntero IX (Ahora es más fácil, ya tenemos la columna lógica)
    LD A, (ficha_columna)   ; A = 0..6
    LD C, A                 ; C = Columna
    
    LD HL, tablero_logico
    LD B, 0
    ; BC = C * 7
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
    ; Borrar de arriba
    LD A, (ficha_columna)
    ; Calculo visual inline
    ADD A, A
    ADD A, A
    ADD A, COLUMNA_INICIAL
    LD L, A
    LD H, 2
    CALL borrar_ficha
    
    ; Pintar en primera casilla
    INC H
    INC H
    INC H               ; H=5
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
    ; 5. Fijar ficha en memoria
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
    ; Resetear posición lógica al centro o inicio (opcional, o dejar donde estaba)
    ; El profe suele reiniciar en 0 o mantener. Reiniciamos a 0 para consistencia.
    LD A, 0
    LD (ficha_columna), A
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

