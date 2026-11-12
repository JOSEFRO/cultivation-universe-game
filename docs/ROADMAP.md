# Hoja de ruta de Siete Raíces

## Dirección aprobada del proyecto

- **Identidad visual:** cinematográfica 3D. Composición de cámara 3/4, escenarios con profundidad y escala, iluminación atmosférica, siluetas legibles, efectos de cultivo controlados y animaciones con intención narrativa.
- **Experiencia:** social. El mundo debe facilitar encuentros, grupos, exploración cooperativa y progresión compartida, con controles de privacidad y seguridad.
- **Plataforma de desarrollo:** Godot 4. Se conserva el proyecto y la estructura actual; no se reinicia ni se migra de motor por estas decisiones.
- **Regla de producción:** primero completar una experiencia vertical de alta calidad en una región; después extender los estándares al resto.

## Fase 0 — Fundamentos (completada)
- [x] Proyecto Godot 4 importable.
- [x] Escena principal y navegación inicial.
- [x] Datos de las siete raíces.
- [x] Principios narrativos y pilares de diseño.

## Fase 1 — Creación del cultivador (base implementada)
- [x] Nombre y procedencia.
- [x] Afinidad inicial entre las siete raíces.
- [x] Elección de camino: Cuerpo, Alma, Leyes o Ruptura.
- [x] Ficha personal con reino y atributos iniciales.
- [x] Guardado y recuperación local del personaje.
- [ ] Linaje, raza, cuerpo especial y talentos.
- [ ] Potencial oculto y rasgos únicos.

## Fase 2 — Primer ciclo explorable (prototipo en desarrollo)
- [x] Mapa de cinco regiones.
- [x] Cinco escenas 3D procedurales con cámara 3/4.
- [x] Movimiento provisional, carrera y salto.
- [x] Diez misiones y cinco aventuras iniciales.
- [x] Tablero de misiones con progreso y recompensas locales.
- [x] Registro de descubrimientos por región.
- [ ] Modelo humanoide original con rig y animaciones cinematográficas.
- [ ] Interacciones contextuales y objetivos completados mediante acciones dentro del escenario.
- [ ] Audio ambiental, materiales finales y optimización visual.
- [ ] Convertir una región en vertical slice cinematográfica: iluminación, composición, puntos de interés, ambiente sonoro y secuencia introductoria.
- [ ] Reemplazar progresivamente la geometría provisional por arte final sin romper el controlador compartido.

## Fase 3 — Capa social y juego cooperativo
- [ ] Definir el espacio social inicial (refugio/centro de reunión) y sus reglas de acceso.
- [ ] Presencia de jugadores, perfiles públicos limitados y estado de actividad configurable.
- [ ] Grupos/partidas privadas para explorar y aceptar misiones juntos.
- [ ] Sincronizar posición, animaciones esenciales, eventos de mundo y estado de misión cooperativa.
- [ ] Progreso individual y recompensas compartidas con reglas claras contra duplicación.
- [ ] Invitaciones, abandonar grupo, reconexión y manejo de desconexiones.
- [ ] Herramientas de seguridad: bloquear, reportar, privacidad y comunicación limitada/predeterminada en la primera versión.
- [ ] Pruebas de red con latencia, pérdida de conexión y distintos tamaños de grupo.

## Fase 4 — Ceremonia de los Siete Juicios
- [ ] Siete pruebas con resultados independientes.
- [ ] Compatibilidad con maestros y escuelas.
- [ ] Posibilidad real de no recibir maestro.
- [ ] Camino independiente sin bloquear el progreso.

## Fase 5 — Sistemas avanzados
- [ ] Entidades del Abismo y del Caos con identidad aparente y verdadera.
- [ ] Maestros errantes y existencias primordiales.
- [ ] Facciones con objetivos propios.
- [ ] Progresión de cultivo basada en transformación y comprensión.
- [ ] Misiones ramificadas y consecuencias persistentes.
- [ ] Eventos sociales de mundo y actividades cooperativas de mayor escala, si las pruebas de rendimiento y comunidad lo justifican.

## Criterios de avance
1. No marcar una función como completada solo porque exista una pantalla o un botón: debe funcionar dentro del juego y superar una prueba.
2. La primera región debe alcanzar el estándar visual y jugable antes de producir arte final para las cinco.
3. El modo individual debe seguir funcionando durante el desarrollo de la capa social.
4. El multijugador se incorpora mediante módulos desacoplados; no se mezclará lógica de red con los catálogos narrativos.
5. Mantener las pruebas actuales de datos y arranque, y añadir pruebas específicas para cada nueva función.

> El contenido narrativo de esta fase está marcado como propuesta editorial hasta que se apruebe como canon.
