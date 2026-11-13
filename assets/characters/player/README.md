# Personaje del jugador — importación GLB

La escena de cada región busca opcionalmente este archivo:

`res://assets/characters/player/player.glb`

## Cómo añadirlo
1. Descarga un modelo humanoide que permita su uso dentro de un videojuego.
2. Comprueba que el paquete incluya licencia/permiso de uso y conserva el texto de licencia.
3. Extrae el archivo GLB en esta carpeta y renómbralo exactamente `player.glb`.
4. Abre el proyecto con Godot 4.7.2 y espera a que termine la importación.
5. Ejecuta una región con F6. El modelo sustituirá al maniquí provisional; el CharacterBody3D, colisión y controlador se mantienen.

## Revisión antes de usarlo
- Modelo humanoide completamente vestido, apto para todas las edades.
- Rig/esqueleto humanoide funcional.
- Escala cercana a 1.7–1.9 metros y pies apoyados en el origen.
- Orientación frontal hacia -Z; si el modelo mira a otro lado, corregir la rotación en una escena wrapper.
- Materiales/texturas incluidos o correctamente referenciados.
- Verificar rendimiento y que el modelo no sobrepase la colisión.

## Importante
El cargador actual instancia el GLB como visual. No retargetea ni reproduce automáticamente sus animaciones. La integración de locomoción requiere revisar los nombres del esqueleto y de los clips, y preparar un AnimationPlayer/AnimationTree compatible.

No subir aquí un archivo si su licencia prohíbe redistribuir el modelo fuente. En ese caso, mantenerlo localmente y registrar su origen/licencia en `assets/ASSET_CREDITS.md`.
