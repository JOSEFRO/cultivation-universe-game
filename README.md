# Siete Raíces — Juego

RPG original de cultivo desarrollado con **Godot 4**. Este repositorio contiene el prototipo jugable y las escenas 3D iniciales del universo.

## Estado actual

**Vertical slice de las primeras cinco regiones en desarrollo.**

- Creación del cultivador con nombre, procedencia, afinidad y camino.
- Códice de las siete raíces y ficha personal.
- Guardado local de personaje y estadísticas.
- Prácticas iniciales de meditación, entrenamiento y exploración.
- Mapa con cinco regiones 3D seleccionables.
- Diez misiones iniciales y cinco aventuras conectadas a las regiones.
- Registro de descubrimientos por región.
- Movimiento WASD, carrera, salto y cámara 3/4 con un personaje provisional.

El personaje visible en las escenas es todavía un maniquí geométrico. El rig humanoide final y las animaciones cinematográficas importadas siguen pendientes.

## Primeras cinco regiones

1. Continentes Mortales
2. Dominio de las Sectas
3. Mar de los Antiguos
4. Cielos Fragmentados
5. Dominio de las Raíces

Las misiones incluyen exploración, investigación, diplomacia, memoria, enigmas, restauración y cultivo. El tablero actual registra pasos de misión como prototipo; las interacciones contextuales dentro del mundo se desarrollarán después.

## Arquitectura de contenido

Los catálogos JSON están en `data/`. El contenido añadido en esta fase está marcado como `proposal`, no como canon definitivo. Consulta [docs/LIBRARIES_AND_CONTENT_ARCHITECTURE.md](docs/LIBRARIES_AND_CONTENT_ARCHITECTURE.md) y [docs/CONTENT_ORIGINALITY.md](docs/CONTENT_ORIGINALITY.md).

## Validar datos

Con Godot 4.3 o compatible:

```bash
godot --headless --path . --script res://tests/validate_data.gd
```

La prueba valida siete raíces, cinco regiones, diez misiones, cinco aventuras, referencias entre misiones y regiones e IDs globales únicos. También comprueba el arranque headless; no sustituye una prueba visual manual.

## Abrir el proyecto

1. Instala Godot 4.3 o una versión 4.x compatible.
2. En el gestor de proyectos, selecciona **Importar**.
3. Abre este repositorio y ejecuta `project.godot`.

## Exportación web

Consulta [docs/WEB_EXPORT.md](docs/WEB_EXPORT.md). Antes de publicar, genera una exportación Web real desde Godot; no subas archivos WASM/PCK ficticios.

## Principio central

Ningún personaje tiene garantizada la grandeza por su nacimiento, talento o maestro.
