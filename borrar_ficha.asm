borrar_ficha:
    PUSH DE
    LD D, 0             ; Color 0 para borrar
    CALL dibujar_ficha  ; Usamos dibujar_ficha directamente
    POP DE
    RET