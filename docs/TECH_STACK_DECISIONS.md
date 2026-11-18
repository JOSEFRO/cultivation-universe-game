# Decisiones de arquitectura: Siete Raíces

Evaluación de los complementos propuestos para el prototipo Godot 4.7.2. La prioridad es tener una base ejecutable, comprensible y comprobable antes de sumar dependencias.

## Incorporación conceptual / selección

| Recurso | Uso previsto | Decisión |
|---|---|---|
| [Skelerealms](https://github.com/SlashScreen/skelerealms) | Persistencia entre escenas, actores, facciones, atributos y navegación de mundo abierto | No instalar todavía: está en alpha y no incluye gameplay, terreno, interfaz, diálogos ni misiones. Adoptar sus ideas de componentes y persistencia cuando haya varias regiones. |
| [Pandora](https://github.com/bitbrain/pandora) | Editor de datos RPG para objetos, habilidades, criaturas y botín | No instalar todavía: el propio proyecto lo declara alpha y no apto para producción. Mantener los datos iniciales como recursos sencillos hasta que el esquema se estabilice. |
| [Terrain3D](https://github.com/TokisanGames/Terrain3D) | Terreno editable de gran extensión, pintura, LOD y vegetación | Candidato principal para la fase de regiones 3D. Elegir una versión compatible con Godot 4.7.2 y validar binarios/renderizador antes de añadirla. |
| [Dialogic](https://github.com/dialogic-godot/dialogic) | Diálogos visuales, personajes y secuencias narrativas | Alternativa válida si se prioriza un editor visual de escenas y líneas de diálogo. |
| [Dialogue Manager](https://github.com/nathanhoad/godot_dialogue_manager) | Diálogo ramificado en archivos de texto, condiciones y cambios de estado | Selección preferida para el primer prototipo narrativo: más simple de versionar y probar. No instalar Dialogic y Dialogue Manager simultáneamente. |
| [Expresso Inventory System](https://github.com/expressobits/inventory-system) | Inventario con recursos, categorías, hotbar y fabricación | No integrar todavía: su rama principal incluye un plugin C++ y aumenta la complejidad de compilación. |
| [GLoot](https://github.com/peter-kish/gloot) | Inventario, prototipos de objetos, límites y UI base | Candidato preferido para una primera versión de inventario; evaluar la versión 3.x y su API antes de integrarlo. |
| [ProtonScatter](https://github.com/HungryProton/scatter) | Distribución procedural de árboles, rocas, hierba y decoración | Reservar para el editor de regiones cuando existan modelos y materiales definitivos. Verificar versión exacta para Godot 4.7.2. |
| [Phantom Camera](https://phantom-camera.dev/) | Seguimiento, transiciones y cámaras cinematográficas | Candidato para sustituir la cámara provisional cuando se definan las escenas, los encuadres y el control del jugador. |
| [Dynamic Day Night Cycles](https://github.com/eisclimber/DynamicDayNightCycles) | Amanecer, día, atardecer y noche según ciclo configurable | Adaptar el concepto de ciclo y shader; integrar el plugin después de fijar el reloj y la iluminación del mundo. |
| [Asset Library #1919](https://godotengine.org/asset-library/asset/1919) | Recurso indicado por el usuario | Pendiente de identificar y validar compatibilidad antes de usarlo. |
| [Godot Jolt](https://github.com/godot-jolt/godot-jolt) | Motor de física 3D | Godot 4.7 ya incluye integración de Jolt en el motor; no añadir la extensión externa salvo que se necesiten sus funciones específicas adicionales. |

## Orden recomendado

1. Prólogo jugable y controles básicos.
2. Datos de misiones y diálogos con Dialogue Manager.
3. Inventario y objetos con GLoot.
4. Cámara cinematográfica con Phantom Camera.
5. Región extensa con Terrain3D.
6. Vegetación y decoración procedural con ProtonScatter.
7. Ciclo día/noche y persistencia entre regiones.
8. Evaluar Skelerealms o Pandora solo cuando el diseño de facciones, actores y datos esté estabilizado.

## Regla de integración

No se copian complementos completos ni se incorporan dependencias únicamente por popularidad. Cada plugin debe tener versión compatible, licencia revisada, pruebas en el proyecto y una función concreta que ya se necesite. El prototipo debe seguir abriendo aunque los complementos opcionales no estén instalados.
