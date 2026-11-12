# Preparar la exportación Web de Godot para Vercel

El proyecto principal se desarrolla y conserva en Godot. Vercel alojará únicamente la exportación estática para navegador.

## Requisitos
- Godot 4.x instalado.
- Plantillas de exportación de la misma versión instaladas desde **Editor → Manage Export Templates**.
- Un navegador moderno compatible con WebAssembly y WebGL 2.

## Exportar
1. Abre `project.godot` en Godot.
2. Abre **Project → Export**.
3. Añade el preset **Web**.
4. Configura el archivo de salida como `web/index.html`.
5. Exporta el proyecto. Godot debe generar en `web/` el HTML, JavaScript, archivo PCK y módulos WebAssembly necesarios.
6. Comprueba localmente la exportación con un servidor HTTP; no abras el HTML directamente como archivo.
7. Cuando la exportación esté probada, confirma que los archivos generados estén en el repositorio y despliega el proyecto `siete-raices-game` de Vercel con `web` como directorio de salida.

## Importante
- No se deben inventar ni subir archivos `.wasm` o `.pck` vacíos: deben proceder del exportador de Godot.
- La carpeta `web/` puede estar vacía en Git hasta que se genere la exportación real.
- Mantén el proyecto Godot original como fuente principal; la exportación web es un artefacto de distribución.
- Si se habilitan hilos en la exportación, habrá que configurar los encabezados de aislamiento cruzado requeridos por Godot y verificar las restricciones del navegador. No actives esa opción sin necesidad.
