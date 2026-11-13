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


## Paquetes gratuitos priorizados (investigación 12-11-2026)

### Personajes
1. **Quaternius — Characters: Fantasy Races**  
   https://quaternius.com/packs/charactersfantasyraces.html  
   12 modelos humanoides (6 masculinos y 6 femeninos), rig humanoide y variantes de color. La página indica que 60–70% del pack está disponible gratis, con FBX/GLB/glTF en la descarga estándar. Estilo estilizado/low-poly; no es realismo tipo MMORPG. Revisar la licencia vigente en la ficha antes de redistribuir.
2. **Quaternius — RPG Character Pack**  
   https://quaternius.com/packs/rpgcharacters.html  
   Seis personajes de fantasía riggeados, animados y texturizados. Buena opción inmediata para NPC/prototipo; estilo estilizado. La ficha/catálogo consultado lo marca CC0.
3. **Quaternius — Universal Base Characters**  
   https://quaternius.com/packs/universalbasecharacters.html  
   Bases humanoides riggeadas y peinados; útil para crear un protagonista modular. Necesita ropa/animaciones aparte.
4. **AssetFurnace — Free 3D assets**  
   https://assetfurnace.com/library  
   Biblioteca GLB gratuita con personajes riggeados, entre ellos Kung Fu Hero, Rune Knight y Vanguard, además de props de fantasía. Revisar la licencia individual de cada asset y los términos de descarga.
5. **Polygonal Mind — 100 Avatars**  
   https://polygonalmind.com/100-avatars/  
   Colección de avatares humanoides estilizados; usar como base de NPCs/variantes si el archivo y la licencia de la descarga concreta siguen disponibles. Confirmar licencia en el recurso original.

### Escenarios y materiales
- **Quaternius** — kits gratuitos de naturaleza, ruinas, edificios y props: https://quaternius.com/
- **Fab — Ancient South Indian Temple Ruins (Free / CC0)**: https://www.fab.com/listings/a3910c1c-1733-4851-8057-f6b433e1804b — paquete GLB de ruinas/templos; revisar escala y estilo para adaptarlo a arquitectura original del juego.
- **Poly Haven** — HDRI, modelos y texturas CC0: https://polyhaven.com/
- **ambientCG** — materiales PBR CC0: https://ambientcg.com/

### Selección recomendada para Siete Raíces
- Protagonista inicial: Universal Base Characters + ropa modular de fantasía + animaciones humanoides.
- NPCs y enemigos de prueba: RPG Character Pack / Fantasy Races.
- Personaje de artes marciales: Kung Fu Hero de AssetFurnace, sujeto a revisar licencia y rig.
- Cielos Fragmentados: ruinas/templos modulares, rocas, naturaleza y HDRI; no llenar el mapa solo con cilindros.
- Mantener claro que estos paquetes son en su mayoría estilizados. Para igualar el acabado realista de la referencia del usuario, harán falta modelos originales de mayor detalle, trabajo de materiales/ropa/cabello y optimización.

### Licencia y estado
La investigación identifica descargas gratuitas, pero no significa que los archivos se hayan descargado o incorporado al repositorio. Cada pack debe verificarse en su ficha original; no redistribuir archivos fuente si la licencia lo prohíbe. El GLB del jugador sigue siendo opcional en `assets/characters/player/player.glb`.


## Revisión enfocada en estética china (12-11-2026)

El requisito artístico del proyecto es ahora explícitamente **fantasía china / xianxia / wuxia / donghua**, con hanfu, peinados tradicionales, arquitectura china y personajes humanos. No usar packs genéricos medievales europeos como protagonistas.

### Personajes y ropa — opciones gratuitas
- **Meshy — galería Xianxia**: https://www.meshy.ai/tags/xianxia  
  La página anuncia modelos descargables en GLB/FBX/OBJ y etiqueta CC0 para modelos ya publicados en la galería. Hay ejemplos con hanfu, ornamentos de cabello y estética xianxia. Revisar la licencia del modelo individual y que el archivo tenga malla, materiales y rig útil para Godot antes de integrarlo.
- **Meshy — galería Wuxia**: https://www.meshy.ai/tags/wuxia  
  La galería anuncia descargas gratuitas en formatos de intercambio y CC0 para assets publicados. Elegir únicamente modelos de personajes chinos completos, no imágenes de muestra ni archivos sin geometría utilizable.
- **Meshy — galería Cultivator**: https://www.meshy.ai/tags/cultivator  
  Incluye diseños de cultivadores de estética donghua/xianxia; verificar licencia y rig por modelo.
- **Sketchfab — Traditional Chinese Hanfu dress**: https://sketchfab.com/3d-models/traditional-chinese-hanfu-dress-2704256bc587491e80ab3109d1a0839f  
  Recurso gratuito con licencia CC BY: requiere atribución al autor. Es una prenda, no un personaje completo ni un rig; podría servir para pruebas de vestuario si la malla puede adaptarse a un cuerpo compatible.

### Arquitectura y ambientación china gratuita
- **Chinese Four-corner Pavilion (itch.io)**: https://vvaytoyek.itch.io/chinese-four-corner-pavilion-free  
  Pabellón 3D gratuito, CC0, sin texturas; útil para templos, patios y zonas de descanso.
- **Traditional Chinese Pagoda Temple (Archade)**: https://archade.app/marketplace/3d-models/architectural-elements/traditional-chinese-pagoda-temple-sketchup  
  Descarga gratuita SKP, uso comercial permitido bajo licencia del sitio, sin redistribución del archivo original. Requiere conversión a GLB/GLTF mediante Blender.
- **Chinese Palace Pack (FreeGameSprites)**: https://freegamesprites.com/en/packs/chinese  
  Contiene arquitectura y elementos chinos, pero es un pack 2D/pixel art, no modelos 3D. No usarlo para sustituir geometría 3D.

### Qué se recomienda integrar primero
1. Un personaje completo xianxia con cuerpo, ropa hanfu y rig humanoide descargado de la galería Meshy; validar el archivo y la licencia exacta del modelo.
2. Un segundo personaje con apariencia distinta para NPC.
3. Pabellón chino CC0 como primera estructura de Cielos Fragmentados o Dominios de las Sectas.
4. Vegetación, piedra, tejas, faroles y materiales chinos coherentes; mantener el mismo nivel de detalle y paleta.

### Límites de esta investigación
Las páginas de galería no garantizan que cada resultado tenga rig, animaciones o calidad de producción. No se afirma que los modelos ya estén descargados ni integrados. La integración se marcará como completada solo tras revisar el archivo GLB real, licencia, rig, escala y resultado en Godot.
