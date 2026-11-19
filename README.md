<div align="center">

<img src="https://d8j0ntlcm91z4.cloudfront.net/user_3MJ8xX039ib9919oo3CFVd7NjMx/hf_20261119_141641_b791490c-cf19-4121-bbc9-0b413628b00b.webp" alt="Arte conceptual del videojuego Siete Raíces" width="100%">

# SIETE RAÍCES

**RPG de fantasía y cultivo desarrollado como videojuego independiente en Godot.**

![Estado](https://img.shields.io/badge/estado-prototipo%20en%20desarrollo-orange)
![Godot](https://img.shields.io/badge/Godot-4.x-478CBF?logo=godotengine)
![Lenguaje](https://img.shields.io/badge/lenguaje-GDScript-478CBF)
![Objetivo](https://img.shields.io/badge/plataforma%20objetivo-Windows-0078D6?logo=windows)

[Repositorio del juego](https://github.com/JOSEFRO/cultivation-universe-game) · [Portal oficial](https://github.com/JOSEFRO/cultivation-universe-web) · [Incidencias](https://github.com/JOSEFRO/cultivation-universe-game/issues)

</div>

## 1. Visión del producto

Siete Raíces es un RPG ambientado en un universo original de fantasía y cultivo. El jugador podrá explorar territorios, descubrir su potencial, conocer personajes y organizaciones, completar desafíos y construir su propio camino.

El proyecto se encuentra en desarrollo. El contenido, los sistemas, el arte y las mecánicas pueden cambiar durante la producción.

## 2. Alcance del videojuego

Este repositorio contiene el producto jugable y es responsable de:

- Movimiento y control del personaje.
- Cámara y exploración.
- Interacción con el mundo y sus personajes.
- Misiones, diálogos y decisiones.
- Progresión, habilidades e inventario.
- Sistemas de combate cuando se implementen.
- Guardado y carga.
- Interfaz de juego y accesibilidad.
- Gestión de escenas, recursos y rendimiento.

El portal web es un producto independiente y no debe alojar ni simular estas mecánicas.

## 3. Motor y plataforma

- Motor: Godot Engine 4.x.
- Lenguaje: GDScript.
- Escenas y recursos nativos de Godot.
- Control de versiones: Git y GitHub.
- Plataforma objetivo inicial: Windows.

La versión exacta del motor debe coincidir con la configuración y el flujo de validación del repositorio. Comprueba la versión indicada por el proyecto antes de importar o exportar.

## 4. Estado del desarrollo

| Área | Estado documentado |
|---|---|
| Proyecto base | Disponible |
| Diseño del universo | En desarrollo |
| Regiones iniciales | Prototipos en validación |
| Presentación 3D | Prototipo |
| Misiones y diálogos | En desarrollo |
| Guardado y carga | Pendiente de integración y pruebas |
| Interfaz | En desarrollo |
| Prueba completa en Windows | Pendiente de validación manual |

Los recursos conceptuales y los placeholders no deben presentarse como contenido final ni como mecánicas terminadas.

## 5. Abrir el proyecto

1. Instala una versión compatible de Godot 4.
2. Clona el repositorio:

```bash
git clone https://github.com/JOSEFRO/cultivation-universe-game.git
```

3. Abre Godot Project Manager.
4. Selecciona **Importar** y elige `project.godot`.
5. Espera la importación de recursos y ejecuta la escena principal.

## 6. Validación

Antes de distribuir una build:

- Importar el proyecto sin errores.
- Ejecutar la escena principal.
- Comprobar entradas, cámara y transiciones.
- Verificar colisiones e interacciones.
- Probar guardado y carga cuando estén integrados.
- Revisar errores y advertencias de GDScript.
- Exportar para Windows y ejecutar la build resultante.
- Realizar pruebas visuales y de jugabilidad en hardware real.

Las ejecuciones automatizadas se pueden consultar en [GitHub Actions](https://github.com/JOSEFRO/cultivation-universe-game/actions). Un workflow exitoso no sustituye la prueba de la build exportada.

## 7. Arquitectura y buenas prácticas

- Separar datos, lógica de juego, presentación e interfaz.
- Mantener escenas y scripts con responsabilidades claras.
- Evitar dependencias circulares entre sistemas.
- Centralizar configuración y recursos compartidos.
- Gestionar señales y referencias de nodos de forma segura.
- Documentar controles, estados y transiciones.
- Optimizar modelos, materiales, texturas y efectos según presupuesto de rendimiento.

## 8. Hoja de ruta técnica

1. Consolidar el prólogo jugable y el flujo de escenas.
2. Estabilizar movimiento, cámara e interacción.
3. Integrar diálogos y misiones iniciales.
4. Diseñar progresión y sistemas de juego modulares.
5. Implementar guardado/carga con pruebas.
6. Sustituir placeholders de forma gradual.
7. Preparar builds reproducibles y pruebas en Windows.

## 9. Separación con el portal web

- [Portal Siete Raíces](https://github.com/JOSEFRO/cultivation-universe-web): presentación, lore, galería y noticias.
- Este repositorio: videojuego, gameplay, escenas y sistemas interactivos jugables.

## 10. Licencia

No se ha incorporado una licencia de reutilización. El código, los diseños y los recursos permanecen reservados a su titular salvo autorización expresa.
