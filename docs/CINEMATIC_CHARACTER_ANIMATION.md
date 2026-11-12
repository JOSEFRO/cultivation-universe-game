# Prototipo de personajes cinematográficos — Siete Raíces

## Objetivo

Crear una base reutilizable para personajes humanoides 3D con presentación 2.5D y cámara de tres cuartos. Este primer slice separa locomoción, rig, animación y cámara para poder sustituir el maniquí de prueba por modelos finales sin reescribir el controlador.

## Estado honesto del prototipo

- Incluye controlador de movimiento WASD, carrera, salto, giro amortiguado y cámara 3/4.
- Incluye un maniquí geométrico temporal para comprobar escala, desplazamiento y encuadre.
- El nodo `AnimationTree` queda como punto de integración; todavía no hay un modelo humanoide, esqueleto ni clips cinematográficos importados. Por tanto, este prototipo no debe presentarse como animación humana final.
- El suelo del escenario es de prueba. Antes de usarlo como escena jugable, reemplazar su colisión por un `BoxShape3D` fino o una colisión de terreno adecuada.

## Estructura objetivo

```text
scenes/
  characters/
    humanoid_animation_prototype.tscn
scripts/
  characters/
    humanoid_controller.gd
    three_quarter_camera_rig.gd
assets/
  characters/
    protagonists/
    masters/
    disciples/
    civilians/
  animations/
    locomotion/
    social/
    cultivation/
    cinematic/
  materials/
  facial/
```

## Contrato del rig humanoide

El modelo final debe ser un recurso `.glb` o `.gltf` con:

- Esqueleto humanoide consistente, con pelvis, columna, cuello, cabeza, brazos, manos, piernas y pies.
- Escala de referencia cercana a 1.7–1.9 m.
- Orientación frontal hacia -Z.
- Animaciones separadas o una biblioteca con nombres estables: `Idle`, `Walk`, `Run`, `StartWalk`, `StopWalk`, `TurnLeft`, `TurnRight`, `JumpStart`, `FallLoop`, `Land`, `Meditate`.
- Root motion desactivado inicialmente: el controlador mueve el cuerpo y el rig anima la pose. Se evaluará root motion para cinemáticas cuando haya clips compatibles.
- Materiales optimizados y texturas comprimidas para el objetivo de hardware.

## AnimationTree de producción

Crear un `AnimationTree` con un `AnimationNodeStateMachine` raíz:

- `Idle`: reposo con respiración y micro movimientos.
- `Locomotion`: `AnimationNodeBlendSpace1D` entre `Walk` (0.45) y `Run` (1.0), usando `parameters/Locomotion/blend_position`.
- `Air`: mezcla de salto/caída/aterrizaje.
- Transiciones con cross-fade de 0.12–0.25 s para locomoción y 0.2–0.4 s para estados de cultivo.
- Más adelante: capa aditiva para respiración, mirada, cabello/ropa secundaria y gestos; no mezclar todas las animaciones en una sola máquina.

El script intenta utilizar `parameters/StateMachine/playback` y `parameters/Locomotion/blend_position` cuando el árbol esté configurado. Si no existe el árbol o los parámetros, el movimiento físico sigue funcionando.

## Cámara 3/4

- Perspectiva en tres cuartos, FOV inicial 42°.
- Seguimiento amortiguado; objetivo a la altura del torso/cabeza.
- Cámara no controlada por el mouse en el primer slice para preservar lectura espacial.
- Más adelante, permitir ajuste limitado de órbita y encuadre para escenas narrativas.

## Controles del prototipo

- W/A/S/D: desplazamiento relativo a la cámara.
- Shift: correr.
- Espacio: salto.

## Próximas fases

1. Importar un modelo humanoide original con licencia adecuada y validar su rig.
2. Añadir clips de locomoción y configurar el AnimationTree descrito arriba.
3. Implementar IK de pies/manos, inclinación corporal, mirada y animación facial.
4. Añadir ropa/cabello secundarios con física moderada y LOD.
5. Integrar estados de meditación y cultivo con VFX.
6. Perfilar en Compatibility renderer y probar con varios NPC simultáneos.

## Criterios de aceptación

- El personaje acelera y frena suavemente, sin deslizarse de forma evidente.
- Gira hacia la dirección de movimiento sin cambios bruscos.
- El movimiento es relativo a la cámara.
- La cámara mantiene el encuadre 3/4 sin vibración apreciable.
- El controlador no depende de un modelo concreto.
- Los clips importados se mezclan sin saltos visibles.
