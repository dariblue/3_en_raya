pausa_breve:
    PUSH BC
    LD B, 2
.p_loop:
    PUSH BC
    LD BC, $1000
.d_loop:
    DEC BC
    LD A, B
    OR C
    JR NZ, .d_loop
    POP BC
    DJNZ .p_loop
    POP BC
    RET
