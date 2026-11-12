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
scripts/world_data.gd expone get_roots(), get_entries(category) y validate_all_catalogs(). Comprueba existencia, apertura, versión, tipo de colección, campos obligatorios, estados editoriales e IDs duplicados entre todas las categorías. main.gd ejecuta la validación al iniciar.

## Prueba automatizada
Con Godot 4.3 o compatible, ejecutar:
godot --headless --path . --script res://tests/validate_data.gd

El workflow de GitHub Actions instala Godot 4.3.0 y ejecuta esta prueba en cada pull request hacia main. La prueba comprueba siete raíces, nueve catálogos y validación global. El workflow también inicia la escena principal en modo headless para detectar errores de arranque de main.gd.

## Exportación
Los catálogos son JSON leídos desde res:// con FileAccess. En el preset de exportación de Godot se deben incluir explícitamente los archivos *.json (o todos los archivos del proyecto) para que estén en el PCK. Una ejecución dentro del editor no demuestra que los archivos estén empaquetados. Confirmar esta inclusión al crear la exportación final.

La documentación de Godot diferencia FileAccess para texto/archivos de usuario y ResourceLoader para recursos importados. Si los datos necesitan edición visual avanzada, migrar a Resource tipados .tres manteniendo JSON como formato de intercambio.

## Integridad editorial
Los IDs deben ser slugs estables y globalmente únicos. status acepta canon, proposal, pending o deprecated. Las referencias entre maestros, facciones, técnicas y artefactos deben validarse antes de usarse en el juego.

## Guardado
Las partidas deben tener su propia versión de formato y migraciones independientes de la versión de catálogos. Nunca modificar un save antiguo sin comprobar su versión.

## Documentación oficial consultada
- [Godot 4.3 — FileAccess](https://docs.godotengine.org/en/4.3/classes/class_fileaccess.html).
- [Godot — ResourceLoader](https://docs.godotengine.org/en/stable/classes/class_resourceloader.html).
- [Godot — ResourceSaver](https://docs.godotengine.org/en/stable/classes/class_resourcesaver.html).
- [Setup Godot GitHub Action](https://github.com/chickensoft-games/setup-godot).
