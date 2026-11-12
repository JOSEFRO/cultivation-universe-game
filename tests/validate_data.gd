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
		"regions",
	]
	for category in categories:
		var entries: Array[Dictionary] = WorldDataScript.get_entries(category)
		if category == "regions" and entries.size() != 5:
			push_error("Se esperaban cinco regiones iniciales.")
			quit()
			return
		if category == "missions" and entries.size() < 10:
			push_error("Se esperaban al menos diez misiones iniciales.")
			quit()
			return
		if category == "adventures" and entries.size() < 5:
			push_error("Se esperaban cinco aventuras iniciales.")
			quit()
			return

	var region_ids := {}
	for region in WorldDataScript.get_entries("regions"):
		region_ids[region["id"]] = true

	for mission in WorldDataScript.get_entries("missions"):
		if not region_ids.has(mission.get("region_id", "")):
			push_error("Misión sin región válida: " + str(mission.get("id", "unknown")))
			quit()
			return
		if int(mission.get("required_steps", 0)) < 1:
			push_error("Misión sin pasos válidos: " + str(mission.get("id", "unknown")))
			quit()
			return

	if not WorldDataScript.validate_all_catalogs():
		push_error("Los catálogos no superaron la validación global.")
		quit()
		return

	print("SIETE RAÍCES: regiones, misiones y catálogos validados correctamente.")
	quit()
