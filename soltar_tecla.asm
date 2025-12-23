; ==============================================================================
; Rutina: Soltar_Tecla
; Entrada: Puerto C (definido previamente)
; Salida: Espera activa hasta que no se detecte pulsación
; Datos del programa: Ninguno
; ==============================================================================

Soltar_Tecla:           ; Rutina de espera hasta que se suelta la tecla
    IN A,(C)            ; Leer del puerto que se ha definido en Lee_Tecla
    AND $1F
    CP $1F              ; Comprobar que no hay tecla pulsada
    JR NZ,Soltar_Tecla  ; esperar hasta que no haya tecla pulsada
    RET