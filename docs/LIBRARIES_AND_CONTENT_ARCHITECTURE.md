# Arquitectura de contenido — Siete Raíces (Godot)

## Decisión tecnológica
Godot 4 incluye las herramientas necesarias:
- JSON y FileAccess para leer catálogos compartidos.
- Resource y archivos .tres para contenido editable desde el Inspector.
- ResourceLoader y ResourceSaver para recursos tipados.
- FileAccess en user:// para partidas guardadas.

No se añade un plugin externo de datos en esta etapa.

## Catálogos
data/roots.json contiene las siete raíces establecidas. Los siguientes archivos versionados empiezan vacíos con version: 1 e items: []:
- maestros;
- reinos de cultivo;
- artefactos;
- técnicas;
- facciones;
- aventuras;
- misiones;
- criaturas;
- civilizaciones.

No se agrega contenido propuesto como canon.

## Carga y validación
scripts/world_data.gd expone get_roots() y get_entries(category). Comprueba existencia, apertura, versión, tipo de colección, campos obligatorios e IDs duplicados dentro de cada categoría.

## Exportación
Los catálogos son JSON leídos desde res:// con FileAccess. En el preset de exportación de Godot se deben incluir explícitamente los archivos *.json (o todos los archivos del proyecto) para que estén en el PCK. Una ejecución dentro del editor no demuestra que los archivos estén empaquetados. Confirmar esta inclusión al crear la exportación final.

La documentación de Godot diferencia FileAccess para texto/archivos de usuario y ResourceLoader para recursos importados. Si los datos necesitan edición visual avanzada, migrar a Resource tipados .tres manteniendo JSON como formato de intercambio.

## Integridad editorial
Los IDs deben ser slugs estables y globalmente únicos. status acepta canon, proposal, pending o deprecated. Las referencias entre maestros, facciones, técnicas y artefactos deben validarse antes de usarse en el juego.

## Guardado
Las partidas deben tener su propia versión de formato y migraciones independientes de la versión de catálogos. Nunca modificar un save antiguo sin comprobar su versión.
