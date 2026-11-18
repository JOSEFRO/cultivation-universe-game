# Arquitectura del producto — Videojuego Siete Raíces

## Objetivo

`cultivation-universe-game` es el único producto jugable de Cultivation Universe. Se desarrolla en Godot y contiene todas las reglas, estados y sistemas runtime del RPG de cultivación.

## Responsabilidades exclusivas del juego

- Personaje controlable, movimiento, cámara de juego y animaciones.
- Combate, habilidades, atributos, estados y progresión de cultivación.
- IA, NPC, diálogo interactivo y comportamiento de personajes.
- Misiones, objetivos, decisiones y consecuencias.
- Inventario, equipo, objetos, loot, crafting y economía.
- Mundo explorable, regiones, terreno, streaming y navegación.
- Facciones, sectas, reputación y relaciones simuladas.
- Física, colisiones, interacción, guardado/carga y configuración.
- Audio y efectos de gameplay.
- Builds, pruebas jugables y distribución del videojuego.

## Frontera con el portal web

El portal `cultivation-universe-web` es un producto editorial y comunitario independiente. Puede mostrar lore, mapas informativos, fichas de personajes, sectas, bestiario, técnicas, galería, devlogs, roadmap, noticias y enlaces de descarga.

La web no implementa ni sustituye combate, IA, NPC, movimiento, inventario, misiones o progresión. El juego puede publicar builds y datos editoriales para que el portal los presente, pero no depende del portal para ejecutar sus sistemas jugables.

## Arquitectura interna recomendada

1. Core: bootstrap, configuración, escenas, señales y servicios globales mínimos.
2. Actor: controlador del jugador, atributos, estados, animación y componentes reutilizables.
3. World: regiones, terreno, navegación, clima, día/noche y streaming.
4. Gameplay: interacción, combate, habilidades, loot y objetos.
5. Narrative: misiones, diálogos, decisiones, facciones y eventos.
6. Progression: raíces, reinos, meridianos, técnicas, talentos y avance.
7. Inventory: contenedores, equipo, crafting, comerciantes y economía.
8. Persistence: guardado versionado, carga y migraciones.
9. UI: HUD, inventario, diarios, mapas y menús de juego.
10. QA: pruebas unitarias de reglas, integración de escenas y pruebas manuales de gameplay.

Los módulos deben tener límites claros y comunicarse mediante señales, recursos de datos y servicios definidos. Evitar un único script monolítico de escena como arquitectura definitiva.

## Regla de evaluación de dependencias

Un repositorio se evalúa para este proyecto solo si agrega funcionalidad ejecutable al videojuego: combate, IA, NPC, inventario, misiones, mundo abierto, personajes, animación, navegación, física, diálogo runtime, guardado o mecánicas. Bibliotecas de presentación web, CMS, wiki, galerías y comunidad pertenecen al portal.

Antes de integrar un plugin:
- Verificar compatibilidad real con Godot 4.7.2 y el renderer del proyecto.
- Revisar licencia, mantenimiento, dependencias, exportación y plataforma objetivo.
- Probarlo en una rama aislada con una escena de demostración.
- Medir rendimiento y probar su integración con guardado/carga.
- Mantener un adaptador propio para evitar acoplamiento fuerte al plugin.
- No introducir varios plugins que resuelvan el mismo subsistema.
- Registrar versión fijada, procedencia y cambios locales.

## Estado honesto del prototipo

El prólogo actual es un vertical slice inicial con escenario geométrico provisional, movimiento, cámara de seguimiento, HUD y una interacción sencilla. No debe presentarse como mundo abierto ni como juego completo. Los siguientes hitos son controles/personaje de calidad, bucle de combate, diálogo/misiones, inventario/progresión y una región completa con contenido.
