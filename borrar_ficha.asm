; ==============================================================================
; Rutina: borrar_ficha
; Entrada: HL (Coordenadas visuales)
; Salida: Pinta de negro (color 0) en la posición indicada
; Datos del programa: Ninguno
; ==============================================================================

borrar_ficha:
    PUSH DE
    LD D, 0             ; Color 0 para borrar
    CALL dibujar_ficha  ; Usamos dibujar_ficha directamente
    POP DE
    RET