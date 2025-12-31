# Prompt para Gemini Canvas

**Rol**: Eres un redactor técnico experto en ensamblador Z80 y ZX Spectrum. Tu tarea es generar la documentación final de una práctica universitaria que consiste en un juego de "Conecta 4" (4 en Raya).

**Objetivo**: Crear un documento profesional, bien estructurado y visualmente atractivo (usando formato Markdown o el que soporte el canvas) que cubra los siguientes puntos obligatorios.

---

## 1. Descripción de la Práctica
**Instrucción**: Redacta una introducción que explique que el proyecto es una implementación del clásico juego de mesa "Conecta 4" para el microordenador ZX Spectrum.

**Flujo de Ejecución (para describir en texto o sugerir diagrama)**:
1.  **Inicio** (`inicio`): Configuración de la pila (SP) e interrupciones (DI). Pantalla de bienvenida (`bienvenida`).
2.  **Menú Principal**: Solicita al usuario si quiere jugar (`TecladoS_N`).
    -   Si 'N': Fin del programa.
    -   Si 'S': Inicia `partida`.
3.  **Partida** (`partida`):
    -   Inicialización del tablero y variables.
    -   **Bucle de Juego**:
        -   Alternancia de jugadores.
        -   Movimiento de ficha (`jugar_ficha`).
        -   Caída de ficha (`bajar_ficha`).
        -   Comprobación de victoria (`comprobar_ganapuerta`) o tablas.
    -   Fin de partida: Muestra ganador o empate.
4.  **Rejugar**: Pregunta si se quiere jugar otra vez (S/N).
5.  **Fin**: Pantalla de despedida (`adios`).

---

## 2. Descripción de Rutinas Principales
**Instrucción**: Documenta las siguientes rutinas clave utilizando la información técnica extraída del código.

### `mannin` (Main)
-   **Función**: Punto de entrada ($8000). Orquestador principal del flujo del programa.
-   **Detalles**: Gestiona el bucle principal de "Bienvenida -> Partida -> Despedida".

### `jugar_ficha`
-   **Función**: Gestiona la fase de movimiento lateral de la ficha antes de soltarla.
-   **Entrada**: Variable `ficha_columna`.
-   **Lógica**:
    -   Pinta la ficha en la columna actual.
    -   Lee el teclado (`teclado_Juego`).
    -   Si es Izquierda/Derecha: Borra, actualiza posición y repinta.
    -   Si es Bajar (Drop): Termina la rutina y pasa a `bajar_ficha`.

### `comprobar_ganapuerta` (Comprobar 4 en Raya)
-   **Función**: Verifica si el último movimiento ha generado una línea de 4 fichas.
-   **Entrada**: Registro `IX` apuntando a la última ficha colocada.
-   **Algoritmo**: Escanea en 4 direcciones desde la última ficha:
    1.  Vertical (Abajo).
    2.  Horizontal (Izquierda + Derecha).
    3.  Diagonal \ (Arriba-Izq + Abajo-Der).
    4.  Diagonal / (Abajo-Izq + Arriba-Der).
-   **Salida**: Registro `A` = 1 (Victoria), `A` = 0 (Sigue jugando).

### `teclado_Juego`
-   **Función**: Lee los puertos de entrada para determinar la acción del jugador activo.
-   **Lógica**: Distingue entre Jugador 1 y Jugador 2 para asignar teclas diferentes.
-   **Salida**: Registro `A` con código de acción (-1: Izq, 1: Der, 0: Bajar, $FE: Salir).

---

## 3. Manual de Uso
**Instrucción**: Crea una guía simple para el usuario final explicando cómo jugar.

**Objetivo**: Conectar 4 fichas del mismo color en línea (horizontal, vertical o diagonal) antes que el oponente.

**Controles**:
El juego soporta dos jugadores en el mismo teclado (Split Keyboard).

| Acción | Jugador 1 (¿Rojo?) | Jugador 2 (¿Amarillo?) |
| :--- | :--- | :--- |
| **Mover Izquierda** | Tecla **Q** | Tecla **O** |
| **Mover Derecha** | Tecla **W** | Tecla **P** |
| **Soltar Ficha** | Tecla **S** | Tecla **L** |

**Controles Globales**:
-   **Salir de la partida**: Tecla **F**.
-   **Responder Sí/No**: Teclas **S** y **N**.

---

## 4. Porcentajes de Participación
**IMPORTANTE**: Esta sección es obligatoria. Por favor, rellena la siguiente tabla con los nombres de los integrantes y su porcentaje de contribución al proyecto.

| Nombre del Alumno | Porcentaje de Participación | Tareas Principales |
| :--- | :---: | :--- |
| [Nombre 1] | [XX]% | [Ej. Lógica de juego, Rutinas de vídeo] |
| [Nombre 2] | [XX]% | [Ej. Control de teclado, Diseño de pantallas] |
| [Nombre 3] | [XX]% | [Ej. Documentación, Debugging] |

*(Nota: La suma debe ser 100%)*

---

**Instrucciones de formato para Gemini**:
-   Usa negritas para comandos y teclas.
-   Crea diagramas de flujo en formato Mermaid si es posible, o descríbelos claramente en pasos.
-   Mantén tono académico pero accesible.
