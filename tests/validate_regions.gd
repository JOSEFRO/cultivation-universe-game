extends SceneTree

const WORLD_DATA = preload("res://scripts/world_data.gd")

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	var regions: Array[Dictionary] = WORLD_DATA.get_entries("regions")
	if regions.size() != 5:
		push_error("La prueba esperaba exactamente cinco regiones.")
		quit(1)
		return

	for region in regions:
		var scene_path := str(region.get("scene_path", ""))
		var packed := load(scene_path) as PackedScene
		if packed == null:
			push_error("No se pudo cargar: " + scene_path)
			quit(1)
			return

		var instance := packed.instantiate()
		if instance == null:
			push_error("No se pudo instanciar: " + scene_path)
			quit(1)
			return

		get_root().add_child(instance)
		await process_frame

		if instance.get_node_or_null("Player") == null:
			push_error("Falta Player en: " + scene_path)
			instance.queue_free()
			quit(1)
			return
		if instance.get_node_or_null("CameraRig/Camera3D") == null:
			push_error("Falta CameraRig/Camera3D en: " + scene_path)
			instance.queue_free()
			quit(1)
			return
		if instance.get_node_or_null("WalkableGround") == null:
			push_error("Falta el suelo con colisión en: " + scene_path)
			instance.queue_free()
			quit(1)
			return

		instance.queue_free()
		await process_frame

	print("SIETE RAÍCES: las cinco regiones se instanciaron correctamente.")
	quit()
