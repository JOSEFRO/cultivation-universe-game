# Siete Raíces — Juego

RPG original de cultivo desarrollado con **Godot 4**. Este repositorio contiene el prototipo de videojuego del universo.

## Estado actual
**Vertical slice inicial en desarrollo.** Ya existe:
- Creación de cultivador con nombre, procedencia, afinidad y camino.
- Códice de las siete raíces.
- Ficha personal con reino y atributos iniciales.
- Prácticas iniciales de meditación, entrenamiento y exploración.
- Guardado local de personaje.

Estas prácticas son una base técnica para probar el ciclo inicial; no representan el sistema definitivo de cultivo, misiones o combate.

## Arquitectura de contenido
Los catálogos JSON están en `data/`. Las siete raíces son el único catálogo con contenido narrativo inicial; maestros, reinos, artefactos, técnicas, facciones, aventuras, misiones, criaturas y civilizaciones comienzan vacíos. Consulta [docs/LIBRARIES_AND_CONTENT_ARCHITECTURE.md](docs/LIBRARIES_AND_CONTENT_ARCHITECTURE.md).

## Validar datos
Con Godot 4.3 o compatible, ejecutar desde la raíz del repositorio:

```bash
godot --headless --path . --script res://tests/validate_data.gd
```

La prueba comprueba la carga de las siete raíces, las nueve categorías y la unicidad global de IDs. No sustituye una prueba visual del juego.

## Abrir el proyecto
1. Instala Godot 4.3 o una versión 4.x compatible.
2. En el gestor de proyectos, selecciona **Importar**.
3. Abre este repositorio y ejecuta `project.godot`.

## Exportación web
Consulta [docs/WEB_EXPORT.md](docs/WEB_EXPORT.md). Antes de exportar, asegúrate de incluir los archivos `*.json` en el preset de exportación.

## Principio central
Ningún personaje tiene garantizada la grandeza por su nacimiento, talento o maestro.
