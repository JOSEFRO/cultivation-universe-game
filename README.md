# SIETE RAÍCES

<p align="center">
  <strong>Un RPG de cultivo, fantasía oriental y exploración de reinos.</strong><br>
  <em>Proyecto independiente en desarrollo activo.</em>
</p>

<p align="center">
  <img alt="Estado: En desarrollo" src="https://img.shields.io/badge/ESTADO-EN%20DESARROLLO-orange?style=for-the-badge">
  <img alt="Motor: Godot 4.7.2" src="https://img.shields.io/badge/GODOT-4.7.2-478CBF?style=for-the-badge&logo=godotengine&logoColor=white">
  <img alt="Plataforma objetivo: Windows" src="https://img.shields.io/badge/PLATAFORMA-WINDOWS-0078D6?style=for-the-badge&logo=windows&logoColor=white">
</p>

**Siete Raíces** es un RPG de cultivo ambientado en un universo de fantasía original. El jugador recorrerá territorios misteriosos, descubrirá su potencial, conocerá maestros y sectas, y tomará decisiones que influirán en su camino.

> **Aviso:** el proyecto está en construcción. Las mecánicas, escenarios, personajes, interfaz y contenido pueden cambiar. No representa todavía una versión final.

## Estado del desarrollo

| Área | Estado |
|---|---|
| Proyecto base en Godot | En desarrollo |
| Diseño del universo y progresión | En desarrollo |
| Cinco regiones iniciales | Prototipos en validación |
| Personaje y presentación 3D | Prototipo visual |
| Misiones, diálogos y decisiones | En desarrollo |
| Guardado y carga | Pendiente de integración y pruebas |
| Interfaz y experiencia de usuario | En desarrollo |
| Compilación para Windows | Prueba automatizada realizada en rama de validación |
| Prueba visual y de juego en Windows real | Pendiente |

### Validación técnica

Se ejecutó una validación automatizada con **Godot 4.7.2** en la rama `test/godot-4.7.2-validation`. La ejecución comprobó la importación del proyecto, la instanciación de las cinco escenas regionales, el arranque de la escena principal y la exportación de Windows.

Esto confirma que el proceso de compilación automatizado terminó correctamente; **no significa que todas las funciones estén terminadas ni que el juego haya superado todavía una prueba visual completa en un equipo Windows**.

- [Consultar la validación en GitHub Actions](https://github.com/JOSEFRO/cultivation-universe-game/actions)
- [Consultar cambios en revisión](https://github.com/JOSEFRO/cultivation-universe-game/pulls)
- [Consultar el historial del proyecto](https://github.com/JOSEFRO/cultivation-universe-game/commits)

## Visión del juego

- Crear y desarrollar un cultivador con identidad y potencial propios.
- Explorar cinco grandes regiones y descubrir sus secretos.
- Participar en la Ceremonia de los Siete Juicios.
- Conocer maestros, personajes y organizaciones con sus propios intereses.
- Elegir un camino independiente o vincularse a una secta.
- Completar misiones, descubrir herencias y tomar decisiones con consecuencias.

## Dirección artística

La dirección visual busca una presentación cinematográfica en **3D**, con cámara en perspectiva 3/4, personajes de fantasía oriental, templos, pagodas, montañas, bosques de bambú, jardines y paisajes de gran escala. Los recursos provisionales se irán sustituyendo y refinando durante el desarrollo.

## Tecnología

- **Motor:** Godot 4.7.2
- **Lenguaje:** GDScript
- **Plataforma objetivo inicial:** Windows
- **Control de versiones:** Git y GitHub

## Cómo abrir el proyecto

1. Instala Godot 4.7.2 o una versión compatible de Godot 4.
2. Clona o descarga este repositorio.
3. Abre el gestor de proyectos de Godot y selecciona **Importar**.
4. Selecciona el archivo `project.godot`.
5. Espera a que Godot importe los recursos y ejecuta el proyecto.

## Próximas prioridades

1. Consolidar la escena principal y la transición entre regiones.
2. Mejorar los modelos, animaciones y presentación del personaje.
3. Desarrollar misiones, diálogos y progresión inicial.
4. Integrar y probar guardado/carga.
5. Realizar pruebas visuales y de jugabilidad antes de publicar una versión jugable.

## Arquitectura del producto\n\nEste repositorio contiene el videojuego jugable desarrollado en Godot. Combate, IA, NPC, movimiento, inventario, misiones, progresión, mundo explorable, física y guardado pertenecen exclusivamente a este producto. El portal oficial y comunitario es un proyecto separado: [cultivation-universe-web](https://github.com/JOSEFRO/cultivation-universe-web). Consulta [docs/PRODUCT_ARCHITECTURE.md](docs/PRODUCT_ARCHITECTURE.md) para los límites y módulos.\n\n## Participación

El proyecto evoluciona por etapas. Las sugerencias y reportes de errores son bienvenidos mediante la sección [Issues](https://github.com/JOSEFRO/cultivation-universe-game/issues).

---

<p align="center">
  <strong>SIETE RAÍCES</strong><br>
  <em>El camino no está escrito. Se cultiva.</em>
</p>


## Primer prólogo explorable

La rama de desarrollo del primer prólogo añade una zona 3D construida con recursos geométricos provisionales del propio motor, sin depender de descargas externas para arrancar:

- Valle del Primer Alba con montañas, arboledas, camino de piedra, islas suspendidas y santuario.
- Cultivador 3D provisional con cámara de seguimiento.
- Movimiento con **WASD** o flechas.
- Primer encuentro interactivo: acércate al Guardián del Primer Umbral y pulsa **E**.
- **Esc** regresa al menú.
- HUD con objetivo de misión y controles.

Este recorrido es un *vertical slice* inicial: demuestra entrada al mundo, desplazamiento, escenario, interacción y una misión sencilla. Los modelos geométricos son placeholders deliberados; todavía no representan los modelos finales de personajes, animaciones, combate, inventario ni mundo abierto.

## Decisiones sobre los complementos investigados

Consulta [TECH_STACK_DECISIONS.md](docs/TECH_STACK_DECISIONS.md) para ver qué proyectos conviene integrar, cuáles requieren pruebas y cuáles se reservan para fases posteriores.


## Galería visual del desarrollo

Esta galería reúne referencias originales que guían la creación del mundo, el personaje y el bestiario. Las animaciones son pruebas de atmósfera/VFX; no son modelos 3D ni gameplay final.

### Mundo y escenarios

<p align="center">
  <img src="https://d8j0ntlcm91z4.cloudfront.net/user_3MJ8xX039ib9919oo3CFVd7NjMx/hf_20261119_134249_59abc2dd-1837-48f6-bd1d-119d8f60b0df.png" alt="Panorama del mundo de Siete Raíces" width="100%">
</p>

<p align="center">
  <img src="https://d8j0ntlcm91z4.cloudfront.net/user_3MJ8xX039ib9919oo3CFVd7NjMx/hf_20261119_134248_65b171d0-1be6-4b2e-833f-a533db8da71a.png" alt="Santuario antiguo y valle de cultivo" width="80%">
</p>

<p align="center">
  <img src="https://d8j0ntlcm91z4.cloudfront.net/user_3MJ8xX039ib9919oo3CFVd7NjMx/hf_20261119_135839_bb2de992-a88f-4fce-b217-f0191767ecc7.gif" alt="Ambiente animado con energía espiritual" width="80%">
</p>

### Personaje protagonista y criatura espiritual

<p align="center">
  <img src="https://d8j0ntlcm91z4.cloudfront.net/user_3MJ8xX039ib9919oo3CFVd7NjMx/hf_20261119_134248_61a28044-93c1-4e96-8246-2aaeb7467b94.png" alt="Concept art del cultivador protagonista" width="42%">
  <img src="https://d8j0ntlcm91z4.cloudfront.net/user_3MJ8xX039ib9919oo3CFVd7NjMx/hf_20261119_134247_68136778-923c-41c4-a409-3f6a979ddc3c.png" alt="Concept art de la criatura guardiana" width="42%">
</p>

### Pruebas de VFX animados

<p align="center">
  <img src="https://d8j0ntlcm91z4.cloudfront.net/user_3MJ8xX039ib9919oo3CFVd7NjMx/hf_20261119_140607_d3357ddf-5e5d-485f-8558-0815f4242ecf.gif" alt="Aura espiritual animada del protagonista" width="42%">
  <img src="https://d8j0ntlcm91z4.cloudfront.net/user_3MJ8xX039ib9919oo3CFVd7NjMx/hf_20261119_140559_bb487f77-8263-40cb-8be0-6efcaf89be75.gif" alt="Aura espiritual animada de la criatura" width="42%">
</p>

**Objetivo de integración:** convertir estas referencias en recursos locales de assets/art/ y recrear los efectos interactivos mediante partículas, materiales emisivos y animaciones nativas de Godot. Las imágenes/GIF alojados externamente son una vista previa documental y no una dependencia necesaria para ejecutar el juego.
