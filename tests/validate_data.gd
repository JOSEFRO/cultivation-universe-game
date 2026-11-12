extends SceneTree

const WorldDataScript = preload("res://scripts/world_data.gd")

func _init() -> void:
	var roots: Array[Dictionary] = WorldDataScript.get_roots()
	if roots.size() != 7:
		push_error("El proyecto debe cargar exactamente siete raíces.")
		quit()
		return

	var categories := [
		"masters", "cultivation-realms", "artifacts", "techniques",
		"factions", "adventures", "missions", "creatures", "civilizations",
	]
	for category in categories:
		var entries: Array[Dictionary] = WorldDataScript.get_entries(category)
		if not entries.is_empty():
			push_error("El catálogo inicial debe estar vacío: " + category)
			quit()
			return

	if not WorldDataScript.validate_all_catalogs():
		push_error("Los catálogos no superaron la validación global.")
		quit()
		return

	print("SIETE RAÍCES: validación de catálogos correcta.")
	quit()
