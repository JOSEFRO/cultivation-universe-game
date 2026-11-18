# Evaluación de complementos de gameplay — Siete Raíces

Objetivo: seleccionar componentes que implementen sistemas runtime reales del RPG Godot 4.7.2. No integrar dependencias por popularidad. Todo candidato debe probarse en una escena aislada y pasar validación de editor, exportación y gameplay.

## Candidatos de los repositorios originales

| Repositorio | Sistema que aporta al juego | Evaluación para Siete Raíces |
|---|---|---|
| [Skelerealms](https://github.com/SlashScreen/skelerealms) | Persistencia entre escenas, navegación por celdas, actores, atributos, inventario/equipo, facciones y paquetes de IA | **Investigar como referencia arquitectónica de mundo abierto.** Su README dice expresamente que no incluye gameplay; no es un RPG listo para integrar y su actividad pública no es reciente. Extraer ideas, no copiar el framework entero. |
| [Pandora](https://github.com/bitbrain/pandora) | Editor de datos RPG para objetos, habilidades, mobs, quests y NPCs | **Herramienta de authoring**, no sistema de combate/runtime por sí sola. Útil si el volumen de datos lo justifica. Verificar estabilidad y formato de recursos antes de adoptarlo. |
| [Terrain3D](https://github.com/TokisanGames/Terrain3D) | Terreno 3D editable, regiones extensas, herramientas de pintura y LOD | **Candidato principal para mundo abierto 3D.** Validar versión exacta, renderer Compatibility y exportación Windows/GPU objetivo antes de integrarlo. |
| [Dialogic](https://github.com/dialogic-godot/dialogic) | Diálogos, personajes, timelines y secuencias narrativas | Alternativa visual completa para narrativa. No combinar con Dialogue Manager en la primera iteración. |
| [Dialogue Manager](https://github.com/nathanhoad/godot_dialogue_manager) | Diálogo ramificado con condiciones y mutaciones en runtime | **Candidato preferido para el primer sistema de diálogo**, ya que el proyecto usa GDScript y necesita diálogos versionables. La rama principal actual es Dialogue Manager 4 para Godot 4.6+; fijar release compatible con 4.7.2. |
| [QuestSystem](https://github.com/shomykohai/quest-system) | Misiones basadas en Resources, API tipada, serialización y localización | **Candidato preferido para misiones**, modular y compatible con Godot 4.4+. Integrar junto a Dialogue Manager mediante IDs/eventos; probar guardado de objetivos. |
| [Expresso Inventory System](https://github.com/expressobits/inventory-system) | Inventario, stacks, hotbar, crafting, categorías, equipo, pickups y demo multiplayer | Funcionalidad amplia, pero la rama principal contiene plugin C++ y requiere CMake/Ninja; rama addon separada. No primera elección hasta verificar binarios y exportación. |
| [GLoot](https://github.com/peter-kish/gloot) | Inventario, prototipos JSON, slots, constraints por peso/rejilla y serialización | **Candidato de inventario modular.** MIT y Godot 4.4+. Comparar con Wyvernbox mediante prototipo antes de elegir. |
| [ProtonScatter](https://github.com/HungryProton/scatter) | Distribución procedural de árboles, hierba, rocas y props sobre geometría | **Candidato para producción de regiones**, no requisito para la lógica del mundo. Usar en editor/proceso de autoría y validar coste de escena final. |
| [Phantom Camera](https://phantom-camera.dev/) | Cámaras de seguimiento, composición, blending y transiciones | Candidato para cámara runtime cinematográfica. Mínimo documentado 4.4; comparar con cámara nativa antes de añadir dependencia. |
| [Dynamic Day Night Cycles](https://github.com/eisclimber/DynamicDayNightCycles) | Cálculo de amanecer/atardecer y variación de duración del día por estación/latitud | Candidato para simulación temporal; el README indica que el avance de tiempo del juego debe alimentar su propiedad `current_time`. Validar integración con reloj y clima propios. |
| [Wyvernbox — Asset Library #1919](https://godotengine.org/asset-library/asset/1919) | Inventario de Action RPG, equipo, objetos multi-slot y varios tipos de inventario | **Candidato de inventario junto a GLoot.** No declararlo ganador sin un prototipo de equipamiento, stacks, drops y guardado. |
| [Godot Jolt](https://github.com/godot-jolt/godot-jolt) | Motor de física 3D | Godot 4.7 ofrece Jolt integrado como opción de física. No sumar extensión externa salvo que una prueba demuestre necesidad concreta. |

## Candidatos adicionales investigados

| Repositorio | Sistema | Decisión |
|---|---|---|
| [Beehave](https://github.com/bitbrain/beehave) | Árboles de comportamiento, blackboards y depuración de IA para NPCs y jefes | **Candidato principal para IA de NPC**, MIT, rama Godot 4.x y pruebas automatizadas. Primero prototipar un NPC patrulla/alerta/combate y medir el coste de muchos agentes. |
| [Godot Gameplay Ability System](https://github.com/LiGameAcademy/godot_ability_system) | Habilidades, atributos, cooldowns, costes, buffs/debuffs, efectos y tags | **Candidato de alto valor para cultivación y combate**, pero versión 0.0.1 y Godot 4.5+. Arquitectura muy alineada con técnicas, estados y reinos; validar exhaustivamente antes de usar como núcleo. |
| [QuestSystem](https://github.com/shomykohai/quest-system) | Misiones modulares | Seleccionado para prototipo de quest runtime; comprobar serialización y objetivos compuestos. |
| [Godot Open RPG](https://github.com/gdquest-demos/godot-open-rpg) | Demo educativa de RPG por turnos, combate, inventario, progresión y transiciones | **Referencia de arquitectura y patrones**, no framework plug-and-play: es un proyecto 2D por turnos y su README indica Godot 4.7.2+; el juego de Siete Raíces es 3D. |
| [Expresso Character Controller](https://github.com/expressobits/character-controller) | Movimiento modular, aceleración, pendientes, sprint, salto, vuelo y agacharse | Candidato para comparar el controlador 3D; revisar si su orientación FPS y capacidades coinciden con cámara 3/4 y animación del juego. |
| [Mixamo Animation Retargeter](https://github.com/raidtheory/godot-mixamo-animation-retargeter) | Retargeting de animaciones Mixamo | Herramienta opcional de pipeline, GPL-3.0 y orientada a Godot 4.3; revisar obligaciones de licencia y probar retargeting nativo de Godot 4.7 antes. |

## Decisiones por subsistema

1. **Control y personaje:** conservar CharacterBody3D como base; comparar controlador propio y Expresso Character Controller con el diseño de cámara 3/4. Importar modelos/animaciones con pipeline documentado y usar retargeting nativo de Godot cuando sea posible.
2. **Combate, atributos y técnicas:** prototipar el Gameplay Ability System en una rama experimental. No acoplar progresión del cultivador a una versión alpha del plugin; diseñar adaptadores propios para atributos, efectos y técnicas.
3. **IA/NPC:** prototipar Beehave con un NPC básico y un enemigo. Evitar árboles de comportamiento para actores que solo necesitan estados simples.
4. **Diálogos:** Dialogue Manager 4, una vez fijada la versión compatible con Godot 4.7.2.
5. **Misiones:** QuestSystem; conectar objetivos a eventos de diálogo, interacción, combate y exploración.
6. **Inventario/equipo:** comparar Wyvernbox y GLoot en la misma escena de prueba: stacks, slots de equipo, restricciones, objetos del mundo y serialización. Elegir uno.
7. **Mundo abierto:** Terrain3D para terreno; ProtonScatter para autoría de vegetación/props; investigar Skelerealms para celdas y persistencia, sin adoptarlo como gameplay.
8. **Cámara:** Phantom Camera frente a cámara nativa con SpringArm3D/Camera3D; decidir según transiciones y composición requeridas.
9. **Tiempo y clima:** prototipar Dynamic Day Night Cycles, pero mantener el reloj y los datos de clima bajo control del juego.
10. **Física:** comenzar con Jolt integrado en Godot 4.7; añadir extensión solo si el perfil de rendimiento o una característica lo exige.

## Plan de prototipos antes de integrar

- P0: controlador 3D, cámara 3/4, locomoción y animación placeholder.
- P1: habilidad de ataque/defensa y modificadores de atributo.
- P2: NPC con patrulla, percepción y reacción.
- P3: conversación con opciones y misión con objetivos persistentes.
- P4: inventario, equipamiento, loot y guardado/carga.
- P5: una región Terrain3D con vegetación procedural y ciclo día/noche.

Cada prototipo debe incluir: versión exacta, licencia, prueba headless, prueba visual manual, exportación Windows, medición de rendimiento y criterio para conservar o descartar la dependencia.

## Regla de integración

No instalar varios plugins que resuelvan el mismo subsistema. No incorporar herramientas editoriales en runtime si no aportan valor al jugador. Cada integración debe poder sustituirse mediante una capa propia y no debe romper el guardado. Mantener el juego ejecutable sin dependencias opcionales no validadas.
