# Diseño técnico: dirección cinematográfica y experiencia social

## Estado y alcance

Decisiones aprobadas para orientar el desarrollo:
- Dirección visual: **cinematográfica 3D**.
- Experiencia: **social**, con cooperación como objetivo de diseño.
- Motor y base existente: **Godot 4**, conservando el controlador compartido, las cinco escenas, los catálogos JSON, la creación de personaje y el guardado local.

Este documento es una especificación de evolución, no afirma que el multijugador o los recursos cinematográficos ya estén implementados.

## 1. Arquitectura que se conserva

Se mantienen:
- `project.godot` y la escena principal.
- `scripts/main.gd` como flujo de entrada actual.
- `scripts/world/region_world.gd` como constructor/controlador compartido de regiones.
- `scripts/characters/humanoid_controller.gd` y `three_quarter_camera_rig.gd`.
- `scripts/world_data.gd` y los JSON de `data/` como fuente de verdad de contenido.
- Las cinco escenas regionales y el guardado local existente.

Las nuevas capacidades deben añadirse en módulos separados. No convertir los JSON de historia en una base de datos de sesiones ni introducir dependencias de red dentro del controlador del personaje.

## 2. Dirección cinematográfica

### Estándar visual
- Mantener cámara 3/4 como punto de partida; permitir encuadres controlados para escenas narrativas sin perder orientación del jugador.
- Usar composición por capas: primer plano, zona jugable y fondo para dar profundidad.
- Diferenciar cada región por paleta, clima, arquitectura, vegetación, escala y diseño sonoro.
- Reservar efectos intensos, partículas y postprocesado para momentos importantes; priorizar lectura y rendimiento durante la exploración.
- Crear secuencias cortas con cámara dirigida para descubrimientos, entradas a región y momentos clave, con opción de omitirlas.
- El jugador debe conservar control y referencias espaciales claras al terminar cada secuencia.

### Pipeline de personaje
1. Mantener el maniquí actual como fallback funcional.
2. Incorporar un modelo humanoide original, rig y esqueleto compatibles.
3. Crear clips base: reposo, caminar, correr, salto, aterrizaje, interacción y meditación.
4. Usar AnimationTree/estados para mezclar locomoción y acciones sin cortar bruscamente.
5. Añadir gestos/animaciones sociales solo después de estabilizar locomoción y sincronización.

### Rendimiento
- Perfil de referencia inicial: PC Windows de gama media; ofrecer ajustes de calidad.
- Medir FPS, memoria, tiempos de cuadro y coste de sombras/partículas por región.
- Usar niveles de detalle, instanciación y límites de efectos según distancia cuando el contenido lo requiera.
- No aumentar la complejidad visual de todas las regiones antes de medir la primera vertical slice.

## 3. Experiencia social por etapas

### Etapa A — Social sin red
Preparar UX y contratos de datos usando el modo individual existente:
- Identidad visible del cultivador y ficha pública mínima.
- Pantallas conceptuales de grupo, invitación y actividad.
- Misiones con metadatos que indiquen si admiten cooperación.
- Reglas de recompensa individual/compartida definidas en datos.
Esta etapa no debe simular que hay otros jugadores conectados.

### Etapa B — Sesiones cooperativas pequeñas
- Crear y cerrar una sesión; entrar mediante invitación o código privado.
- Empezar con grupos pequeños y tamaño configurable, no con un mundo masivo.
- Sincronizar únicamente lo necesario: estado de sesión, transform del jugador, animación esencial, acciones relevantes y eventos de misión.
- Mantener autoridad del anfitrión/servidor para validar progreso y recompensas; el cliente no decide por sí solo que una misión quedó completada.
- Manejar reconexión, salida voluntaria, anfitrión desconectado y estado de misión inconsistente.
- Mantener el modo individual disponible cuando no haya conexión.

### Etapa C — Persistencia y servicios
Antes de seleccionar proveedor, definir interfaces para:
- Autenticación y perfil.
- Presencia y lista de amigos/invitaciones.
- Sesiones y emparejamiento privado.
- Persistencia de progreso compartido.
- Moderación y reportes.

La implementación concreta de backend queda pendiente de una prueba técnica y una decisión de costes/operación. No acoplar el juego a un proveedor hasta validar esa elección.

## 4. Seguridad social y privacidad

- No exigir chat de texto o voz para jugar.
- Primera versión: comunicación limitada, gestos y mensajes predeterminados.
- Controles visibles para bloquear, reportar, abandonar grupo y limitar invitaciones.
- Perfiles con información mínima y opciones de privacidad.
- Validar del lado servidor acciones, recompensas, inventario y progresión compartida.
- No exponer datos personales ni ubicación real de los jugadores.

## 5. Organización de código propuesta

Añadir módulos separados cuando se inicie cada etapa, sin crear archivos vacíos prematuramente:

- `scripts/social/`: perfil público, grupos, invitaciones y presencia.
- `scripts/network/`: sesión, sincronización y reconexión.
- `scripts/services/`: interfaces para autenticación y persistencia remota.
- `scenes/social/`: refugio y pantallas sociales.
- `tests/network/`: pruebas de sincronización, desconexión y validación de progreso.

Los nombres son una convención propuesta; deben adaptarse al árbol real al implementar.

## 6. Orden técnico recomendado

1. Completar interacciones reales de misión en una región.
2. Crear la vertical slice cinematográfica de esa región.
3. Sustituir el maniquí por personaje riggeado y locomoción animada.
4. Definir contrato de misión cooperativa y reglas de recompensa.
5. Prototipar sesión privada de pocos jugadores en una escena de prueba aislada.
6. Probar sincronización y reconexión antes de conectar las cinco regiones.
7. Añadir perfiles/presencia y persistencia remota después de elegir backend.

## 7. Criterios de aceptación

- El juego individual sigue abriendo y guardando partidas.
- Las cinco regiones y sus identificadores/rutas siguen pasando la validación actual.
- Una misión solo se completa por eventos/acciones válidas del mundo.
- La sesión social permite entrar, salir y recuperarse de desconexiones sin corromper el guardado local.
- Las recompensas cooperativas se validan de forma autoritativa.
- La cámara y los efectos cinematográficos no impiden leer objetivos ni controlar al personaje.
- Cada fase se prueba en Godot y en Windows antes de declararse terminada.

## 8. Decisiones todavía abiertas

- Backend de cuentas/persistencia.
- Tamaño definitivo de grupo.
- Si habrá servidores dedicados o sesiones alojadas por jugador.
- Alcance de chat, que no se recomienda para el primer prototipo.
- Presupuesto visual final y plataforma mínima de hardware.
