extends SceneTree

const WorldDataScript = preload("res://scripts/world_data.gd")

func _init() -> void:
	var roots := WorldDataScript.get_roots()
	assert(roots.size() == 7, "El proyecto debe cargar exactamente siete raíces.")

	var categories := [
		"masters", "cultivation-realms", "artifacts", "techniques",
		"factions", "adventures", "missions", "creatures", "civilizations",
	]
	for category in categories:
		var entries := WorldDataScript.get_entries(category)
		assert(entries.is_empty(), "El catálogo inicial debe estar vacío: " + category)

	assert(WorldDataScript.validate_all_catalogs(), "Todos los catálogos deben superar la validación.")
	print("SIETE RAÍCES: validación de catálogos correcta.")
	quit(0)
