# Referencia de personajes — Siete Raíces

## Dirección artística
Referencia visual: MMORPG de fantasía oriental con personajes humanos de proporciones realistas, rostros trabajados, cabello elaborado, capas de ropa, telas con materiales diferenciados y ornamentación original. La referencia del usuario es un artículo sobre la presentación visual de Zhuxian World; sirve como guía de calidad y ambientación, no como fuente de modelos descargables ni autorización para copiar sus personajes.

## Candidatos investigados

### Ara 3D Gen
- Proyecto: https://github.com/TuriaArt/3d-gen-TU
- Uso: generar una base humana riggeada y exportable a GLB/FBX para pruebas y NPC originales.
- Licencia declarada por el proyecto: código MIT; datos base MakeHuman CC0.
- Límite: no equivale a un pack terminado de cultivadores orientales; los atuendos y el acabado visual necesitarán trabajo artístico adicional.
- Revisar las licencias de cada componente y la versión descargada antes de distribuir.

### Fire Cultivator — xiuxian2025
- Página: https://xiuxian2025.itch.io/fire-cultivator-rigged-fantasy-character
- Uso: candidato de personaje xianxia estilizado, con GLB, texturas integradas, rig humanoide y clips.
- Condiciones anunciadas: permite uso en videojuegos comerciales e independientes; prohíbe redistribuir el archivo base por separado.
- Precio mostrado al investigar: US$5.
- Límite: estilo estilizado; no se ha comprado ni descargado en este repositorio. Verificar de nuevo los términos antes de adquirirlo.

### Otros modelos xianxia del mismo autor
- Wood Cultivator: https://xiuxian2025.itch.io/xianxia-cultivator
- Golden Cultivator: https://xiuxian2025.itch.io/01-gold-cultivator
- Earth Cultivator: https://xiuxian2025.itch.io/low-poly-3d-xianxia-daoist-cultivator-model-rigged-and-animated-for-fantasy-rpgs
- Water Cultivator: https://xiuxian2025.itch.io/you-own-this-xianxia-cultivator
- Cada ficha anuncia GLB, rig humanoide y clips. Revisar individualmente condiciones y precio; no asumir que todos tienen términos idénticos.

## Integración técnica ya preparada
Las escenas regionales intentan cargar `res://assets/characters/player/player.glb`. Si el archivo está presente, lo instancian como modelo visual del jugador. Si no está, conservan el maniquí temporal. El controlador y la colisión del jugador permanecen separados del modelo visual.

La carga del GLB no significa que sus animaciones estén conectadas. Para ello se requiere comprobar el esqueleto y los nombres de los clips, y crear/ajustar un AnimationPlayer o AnimationTree.

## Política de recursos
- No copiar modelos, personajes, texturas ni diseños extraídos de Zhuxian World.
- No subir modelos comerciales al repositorio si la licencia prohíbe redistribuir los archivos fuente.
- Guardar licencia, autor, URL y fecha de adquisición en `assets/ASSET_CREDITS.md`.
- No marcar un recurso como integrado hasta que el GLB esté disponible, importe sin errores y se vea correctamente en una escena de prueba.
