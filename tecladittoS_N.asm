tecladoS_N:
;Código completo del tecladito para S o N
    PUSH BC             ; BC al stack para preservar su valor

TSN_N:
    LD BC,$7FFE         ; Escanear línea B,N,M,SYMB,Space
    IN A,(C)
    BIT 3,A
    JR NZ,TSN_S           ; No han pulsado 'N' salta a S
    LD A,'N'
    JR TSN_FIN

TSN_S:            
    LD BC,$FDFE         ; Escanear línea G,F,D,S,A
    IN A,(C)
    BIT 1,A
    JR NZ,TSN_N           ; No han pulsado 'S' salta a N
    LD A,'S'

TSN_FIN:
    PUSH AF             ; Guardar A (contiene 'S' o 'N')
    CALL Soltar_Tecla  ; Esperar a que se suelte la tecla
    POP AF              ; Restaurar A con la tecla detectada
    POP BC              ; Recuperar BC del stack
    RET