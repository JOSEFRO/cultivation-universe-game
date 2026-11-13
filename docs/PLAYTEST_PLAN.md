# Plan de jugabilidad verificable — Siete Raíces

**Objetivo:** conseguir una compilación que el equipo pueda abrir y jugar de principio a fin en Windows, antes de ampliar contenido o producir arte final.

Este documento es una lista de aceptación. Una casilla solo se marca cuando existe evidencia de ejecución; que un script, botón o escena exista no basta.

## Alcance de la primera prueba jugable

La primera entrega de prueba debe permitir:

1. Abrir el juego y llegar a un menú inicial legible.
2. Iniciar una partida nueva y crear/seleccionar el cultivador.
3. Entrar en una región 3D concreta (prioridad: Continentes Mortales).
4. Ver al personaje en pantalla y moverlo con teclado.
5. Controlar la cámara 3/4 sin perder al personaje.
6. Encontrar al menos un punto de interés y activar una interacción contextual.
7. Aceptar una misión, ver su objetivo y completarla mediante una acción del mundo.
8. Recibir una recompensa visible y comprobar el progreso.
9. Abrir el panel de misiones y consultar el estado actualizado.
10. Guardar, cerrar, volver a abrir y recuperar el progreso.
11. Pausar y volver al juego; salir sin corromper el guardado.

## Prioridad de implementación

### P0 — Arranque y menú
- [ ] Confirmar que `project.godot` apunta a la escena principal correcta.
- [ ] Menú inicial gráfico con botones funcionales: Nueva partida, Continuar (si existe guardado), Opciones y Salir.
- [ ] Resolución 1280×720 como base, escalado y navegación por teclado/ratón.
- [ ] Mostrar errores recuperables en pantalla en vez de dejar una pantalla vacía.

### P1 — Personaje y control
- [ ] Personaje visible en la escena jugable; no solo una ficha o retrato.
- [ ] Movimiento WASD/flechas con colisiones y límites del escenario.
- [ ] Cámara 3/4 estable, seguimiento suave y límites para evitar atravesar geometría.
- [ ] Animaciones mínimas de reposo y desplazamiento; si aún son provisionales, documentarlo.
- [ ] Confirmar que el jugador reaparece en un punto válido.

### P2 — Región de prueba
- [ ] Elegir Continentes Mortales como único nivel de validación inicial.
- [ ] Confirmar terreno, iluminación, suelo navegable, caminos y puntos de referencia.
- [ ] Revisar colisiones, obstáculos, bordes, zonas inaccesibles y rendimiento.
- [ ] No exigir que las cinco regiones estén terminadas para validar el primer ciclo.

### P3 — Una misión completa
- [ ] Aceptar misión desde un NPC/tablero interactivo.
- [ ] Mostrar título, descripción, objetivo y progreso.
- [ ] Actualizar el objetivo por una acción real dentro del escenario.
- [ ] Completar misión, entregar recompensa y evitar cobrarla dos veces.
- [ ] Mantener el estado correcto al cambiar de panel o región.

### P4 — Persistencia y estabilidad
- [ ] Guardar personaje, región, posición válida, misión y recompensas.
- [ ] Cargar el guardado después de cerrar el juego.
- [ ] Manejar archivo ausente, incompleto o inválido sin bloquear el inicio.
- [ ] Probar pausa, reanudación y salida.
- [ ] Confirmar que no aparecen errores críticos en la consola.

## Matriz de pruebas manuales en Windows

| ID | Prueba | Resultado esperado |
|---|---|---|
| W-01 | Abrir ejecutable | Se muestra menú, sin pantalla vacía |
| W-02 | Nueva partida | Se inicia flujo de personaje |
| W-03 | Entrar al mundo | Se carga Continentes Mortales |
| W-04 | Movimiento | El personaje se desplaza y colisiona correctamente |
| W-05 | Cámara | El personaje permanece visible |
| W-06 | Interacción | El punto de interés responde |
| W-07 | Misión | Objetivo y progreso se actualizan |
| W-08 | Recompensa | Se acredita una sola vez |
| W-09 | Guardar/cargar | El progreso persiste |
| W-10 | Pausar/salir | La partida se pausa y cierra correctamente |

## Evidencia requerida para aprobar

- Versión exacta de Godot y commit probado.
- Resultado del workflow automatizado.
- Captura del menú inicial.
- Captura del personaje dentro del escenario.
- Captura del panel de misión con progreso.
- Registro breve de cada prueba manual W-01 a W-10.
- Errores encontrados y pasos para reproducirlos.

## Criterio de aprobación

**Prueba jugable aprobada** únicamente cuando W-01 a W-10 se hayan ejecutado en una compilación Windows real y las funciones esenciales respondan correctamente. Las pruebas headless/importación/exportación son necesarias, pero no sustituyen esta validación visual e interactiva.

## Fuera del primer corte

- Multijugador y funciones sociales.
- Las cinco regiones con arte final.
- Combate avanzado, economía extensa y sistemas tardíos de cultivo.
- Cinemáticas completas y doblaje.

Se retomarán después de aprobar el primer ciclo jugable.
