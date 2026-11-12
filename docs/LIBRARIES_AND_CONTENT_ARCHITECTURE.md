# Arquitectura de bibliotecas y contenido

## Fuente de verdad

Los datos jugables viven en archivos JSON versionados dentro de `data/`. `scripts/world_data.gd` centraliza su carga y validación. Los identificadores son globalmente únicos y cada entrada debe incluir `id`, `name`, `status` y `summary`.

## Catálogos

- `roots.json`: siete raíces primordiales.
- `regions.json`: las cinco primeras regiones jugables y sus rutas de escena.
- `missions.json`: misiones asociadas a regiones, objetivos, pasos y recompensas.
- `adventures.json`: arcos que agrupan misiones.
- `masters.json`: propuestas de maestros.
- `cultivation-realms.json`: propuestas de progresión de cultivo.
- `artifacts.json`: reliquias y objetos de exploración.
- `techniques.json`: técnicas de percepción, desplazamiento y concentración.
- `factions.json`: facciones del universo.
- `creatures.json`: criaturas y encuentros.
- `civilizations.json`: comunidades y culturas.

## Estado editorial

Cada entrada utiliza uno de estos estados:

- `canon`: aprobado como parte del universo.
- `proposal`: contenido sugerido, todavía revisable.
- `pending`: pendiente de decisión.
- `deprecated`: retirado, conservado por trazabilidad.

El contenido añadido para las primeras cinco regiones se marca como `proposal`. No debe tratarse como canon hasta su aprobación.

## Contrato de misión

Una misión incluye:
- Identificador único y nombre.
- Región de origen.
- Tipo de actividad.
- Resumen y objetivo.
- Número de pasos requeridos.
- Recompensas aplicables a comprensión, vitalidad o hallazgos.

El tablero guarda el progreso y las misiones completadas en el archivo local del personaje. En esta primera versión, el botón de progreso es una simulación de flujo; la siguiente fase conectará cada objetivo con objetos, puntos de interés y eventos dentro de la región.

## Escenas de región

Las cinco escenas usan un controlador compartido en `scripts/world/region_world.gd`. Cada archivo `.tscn` establece un `region_id`; el controlador carga los datos correspondientes, construye un escenario procedural y crea el jugador provisional con cámara 3/4.

## Validación

`tests/validate_data.gd` comprueba:
- Siete raíces.
- Cinco regiones, diez misiones y cinco aventuras.
- Referencias de misión a regiones existentes.
- Rutas de escena disponibles.
- IDs únicos y estados editoriales válidos en todos los catálogos.
