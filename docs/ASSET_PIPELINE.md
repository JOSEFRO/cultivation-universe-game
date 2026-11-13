# Assetes 3D y biblioteca visual — Siete Raíces

## Objetivo
Sustituir progresivamente el maniquí y la geometría provisional por personajes, criaturas, vegetación, arquitectura, materiales y cielos importables en Godot 4.7.2. La dirección es fantasía de cultivación cinematográfica, cámara 3/4 y lectura clara del jugador.

## Fuentes seleccionadas

> Regla: descargar desde la página original de cada creador y guardar una copia de la licencia/atribución que acompañe al pack. No asumir que todos los elementos de una plataforma comparten licencia.

| Necesidad | Biblioteca / pack | Uso previsto | Formatos / licencia |
|---|---|---|---|
| Personaje base | [Quaternius — Universal Base Characters](https://quaternius.com/) | Reemplazar el maniquí por cuerpo humanoide riggeado | glTF/GLB, FBX; verificar CC0 en la ficha del pack |
| Ropa de fantasía | [Quaternius — Modular Character Outfits: Fantasy](https://quaternius.com/) | Variantes de cultivadores, maestros y NPC | FBX/GLTF; verificar licencia en la ficha |
| Animaciones | [Quaternius — Universal Animation Library 1 y 2](https://quaternius.com/) | Caminar, correr, saltar, reposo, combate y gestos | FBX/GLTF; verificar CC0 en cada pack |
| Paisajes | [Quaternius — Ultimate Nature / Stylized Nature MegaKit](https://quaternius.com/) | Árboles, rocas, plantas, set dressing y siluetas de terreno | FBX/GLTF; verificar licencia en la ficha |
| Ruinas y templos | [Quaternius — Ultimate Modular Ruins](https://quaternius.com/) | Templos, columnas, muros y ruinas antiguas | FBX/GLTF; verificar licencia en la ficha |
| Objetos de mundo | [Quaternius — Fantasy Props MegaKit](https://quaternius.com/) | Altares, cofres, mobiliario, decoración y objetos de misión | FBX/GLTF; verificar licencia en la ficha |
| Terreno y superficies | [ambientCG](https://ambientcg.com/) | Texturas PBR para roca, tierra, piedra, madera y vegetación | Texturas PBR; CC0 según cada recurso |
| Cielos e iluminación | [Poly Haven](https://polyhaven.com/) | HDRI para iluminación ambiental y reflejos | HDRI; CC0 |
| Kit auxiliar | [Kenney](https://kenney.nl/assets) | Props modulares y elementos secundarios de prototipo | Consultar licencia CC0 del catálogo |

## Criterio visual
Quaternius/Kenney tienen una estética estilizada low-poly. Son apropiados para construir una primera versión coherente y jugable, pero no deben presentarse como modelos hiperrealistas. Para evitar que parezca una mezcla de juegos distintos:
- Elegir un pack principal de personajes y uno principal de naturaleza.
- Mantener una escala, paleta, exposición y dirección de luz comunes.
- Usar Poly Haven/ambientCG para materiales y luz, no mezclar HDRI con exposiciones incompatibles.
- Reservar los assets de otros autores para elementos secundarios y registrar siempre su licencia.

## Estructura objetivo del repositorio

```text
assets/
  characters/
    player/
    npcs/
    creatures/
  animations/
    humanoid/
  environments/
    mortal_continents/
    sect_domains/
    ancient_sea/
    fragmented_heavens/
    root_domain/
  props/
    temples/
    ruins/
    cultivation/
  materials/
    terrain/
    stone/
    wood/
  lighting/
    hdri/
  ui/
  ASSET_CREDITS.md
```

## Reglas de integración Godot
1. Preferir GLB/glTF para modelos y escenas 3D; mantener FBX solo cuando sea necesario.
2. Importar cada modelo primero en una escena de prueba y revisar escala, orientación, pivote, materiales y rendimiento.
3. Para personajes, confirmar esqueleto/rig y retargetear animaciones antes de sustituir el controlador actual.
4. No reemplazar el controlador ni el sistema de misiones al importar arte.
5. Instanciar los assets desde escenas reutilizables y mantener cada región desacoplada.
6. No incluir en Git archivos descargados hasta comprobar que la licencia permite redistribución dentro del repositorio.
7. Registrar nombre del pack, creador, URL, licencia, fecha de descarga y archivos utilizados en `assets/ASSET_CREDITS.md`.

## Plan de integración
- Fase A: personaje humanoide base + animaciones de locomoción.
- Fase B: naturaleza, terreno, rocas, templos y props para Cielos Fragmentados.
- Fase C: materiales PBR, HDRI, niebla y partículas.
- Fase D: convertir el escenario de prueba en plantilla visual para las otras cuatro regiones.
- Fase E: revisar tamaño de descarga, FPS y compatibilidad con la GPU objetivo.

## Estado
Esta documentación registra fuentes y criterios; **no afirma que los modelos binarios ya estén descargados ni integrados**. La integración real requiere incorporar los archivos GLB/GLTF y validar sus rigs/materiales dentro de Godot 4.7.2.
