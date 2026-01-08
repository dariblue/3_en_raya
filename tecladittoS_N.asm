tecladoS_N:
    PUSH BC               ; Guardar el registro BC en la pila

tSN_N: 
    LD BC,$7FFE         ; Escanear línea B,N,M,SYMB,Space
    IN A,(C)
    BIT 3,A
    JR NZ,tSN_S           ; No han pulsado 'N' salta a S
    LD A,'N'
    JR tSN_FIN

tSN_S:            
    LD BC,$FDFE         ; Escanear línea G,F,D,S,A
    IN A,(C)
    BIT 1,A
    JR NZ,tSN_N           ; No han pulsado 'S' salta a N
    LD A,'S'

tSN_FIN:
    PUSH AF             ; Guardar A (contiene 'S' o 'N')
    CALL soltar_tecla   ; Esperar a que se suelte la tecla
    POP AF              ; Restaurar A con la tecla detectada
    POP BC              ; Recuperar BC del stack
    RET

