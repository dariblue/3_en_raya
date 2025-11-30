dibujarTablero:
    LD HL, tablerito 
    LD DE, $4000  ; Dirección de pantalla en ZX Spectrum
    LD BC, $5B00 - $4000    ; tamaño: $5B00 - $4000 = $1B00 (6912 bytes) tamaño pantalla ZX Spectrum
    LDIR 

    LD H, 2                 ; Fila 2
    LD L, 0                 ; Columna lógica inicial (0 = Primera columna)
    
    ; Guardar la posición inicial
    LD A, H
    LD (ficha_fila), A
    LD A, L
    LD (ficha_columna), A
    
    LD D, COLOR_JUGADOR_1   ; Color del jugador 1 (rojo)
    RET
