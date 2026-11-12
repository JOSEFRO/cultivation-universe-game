# Arquitectura de contenido — Siete Raíces (Godot)

## Integración aplicada

- `data/roots.json` contiene el catálogo versionado de las siete raíces compartido conceptualmente con la web.
- `scripts/world_data.gd` carga y valida la versión y la cantidad de entradas con las APIs nativas `FileAccess` y `JSON`.
- La creación del personaje y el códice consultan el mismo catálogo, en vez de mantener nombres y descripciones duplicados dentro del script.

## Decisión sobre bibliotecas

Godot ya incluye `Resource`, `JSON` y `FileAccess`. Para maestros, artefactos, técnicas y misiones conviene introducir recursos tipados (`.tres`) cuando esos datos deban editarse desde el Inspector. No se añade un plugin externo de datos mientras las herramientas nativas cubran la necesidad.

## Sincronización

La copia `data/roots.json` debe coincidir con `src/data/roots.json` del repositorio web. Ambas deben conservar `version: 1` y siete IDs estables. Al cambiar el formato, documentar migración antes de modificar partidas guardadas o contenido existente.

El catálogo contiene únicamente las siete raíces establecidas; no introduce una octava raíz ni convierte propuestas narrativas en canon.
