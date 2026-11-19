# Concept art library — Siete Raíces

Generated original concept-art references for the project's visual direction. These are hosted image references; import the files into `assets/art/` before shipping a standalone game build.

## World and environments
- **Hero / floating-island panorama:** https://d8j0ntlcm91z4.cloudfront.net/user_3MJ8xX039ib9919oo3CFVd7NjMx/hf_20261119_134249_59abc2dd-1837-48f6-bd1d-119d8f60b0df.png
- **Ancient sanctuary valley:** https://d8j0ntlcm91z4.cloudfront.net/user_3MJ8xX039ib9919oo3CFVd7NjMx/hf_20261119_134248_65b171d0-1be6-4b2e-833f-a533db8da71a.png

## Characters and creatures
- **Cultivator protagonist concept:** https://d8j0ntlcm91z4.cloudfront.net/user_3MJ8xX039ib9919oo3CFVd7NjMx/hf_20261119_134248_61a28044-93c1-4e96-8246-2aaeb7467b94.png
- **Celestial spirit beast concept:** https://d8j0ntlcm91z4.cloudfront.net/user_3MJ8xX039ib9919oo3CFVd7NjMx/hf_20261119_134247_68136778-923c-41c4-a409-3f6a979ddc3c.png

## Integration notes
- These images are concept references, not rigged 3D models, sprite sheets, or animation assets.
- The web portal may display the hosted image references directly.
- For the Godot game, download approved originals into this repository under `assets/art/world/`, `assets/art/characters/`, and `assets/art/creatures/`; then import them through Godot's asset pipeline.
- Keep final game assets local to the repository so builds do not depend on a third-party image host.


## Animated spiritual ambience

- **Animated hero atmosphere (8-frame seamless GIF):** https://d8j0ntlcm91z4.cloudfront.net/user_3MJ8xX039ib9919oo3CFVd7NjMx/hf_20261119_135839_bb2de992-a88f-4fce-b217-f0191767ecc7.gif
- Intended use: menu background, loading-screen atmosphere, or visual reference for the in-game spirit-energy effect.
- This GIF is a 2D ambience asset, not a 3D animation or a rigged character.

## Low-cost Godot VFX implementation

Use the existing creature concept as the visual reference and build the real-time effect natively in Godot rather than generating another paid video:

1. Add a GPUParticles3D node around the creature, with a small spherical emission volume and low particle count.
2. Use small cyan emissive particles with varied lifetime and upward velocity; keep the effect subtle so the creature remains readable.
3. Add a thin MeshInstance3D torus around the feet with a cyan emissive material. Animate its scale and alpha with an AnimationPlayer for a slow pulse.
4. Add a second, larger ring at a different rotation for parallax; avoid fast flashes and avoid covering the creature silhouette.
5. Expose particle amount, glow strength, and ring speed as exported settings so the effect can be tuned for lower-end hardware.
6. For accessibility and performance, provide a reduced-effects setting and disable the particles when the scene is not visible.

Keep the GIF for menus or reference only. Use native particles and meshes for interactive gameplay effects.


## Animated character and creature VFX previews

- **Cultivator aura loop:** https://d8j0ntlcm91z4.cloudfront.net/user_3MJ8xX039ib9919oo3CFVd7NjMx/hf_20261119_140607_d3357ddf-5e5d-485f-8558-0815f4242ecf.gif
- **Spirit beast aura loop:** https://d8j0ntlcm91z4.cloudfront.net/user_3MJ8xX039ib9919oo3CFVd7NjMx/hf_20261119_140559_bb487f77-8263-40cb-8be0-6efcaf89be75.gif
- Both are short 2D visual previews generated from the approved concept images. They are not skeletal animations, 3D models, or production-ready gameplay effects.
- Use them in README/devlog previews; recreate interactive versions in Godot with GPUParticles3D, emissive materials, rings and AnimationPlayer.
