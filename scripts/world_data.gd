extends RefCounted
class_name WorldData

const ROOTS_PATH := "res://data/roots.json"
const CATALOG_PATHS := {
	"masters": "res://data/masters.json",
	"cultivation-realms": "res://data/cultivation-realms.json",
	"artifacts": "res://data/artifacts.json",
	"techniques": "res://data/techniques.json",
	"factions": "res://data/factions.json",
	"adventures": "res://data/adventures.json",
	"missions": "res://data/missions.json",
	"creatures": "res://data/creatures.json",
	"civilizations": "res://data/civilizations.json",
	"regions": "res://data/regions.json",
}
const EDITORIAL_STATUSES := ["canon", "proposal", "pending", "deprecated"]
const CULTIVATION_PATHS := ["Cuerpo", "Alma", "Leyes", "Ruptura"]
const WORLD_PRINCIPLE := "Ningún cultivador tiene garantizada la grandeza por su nacimiento, talento o maestro."

static func _read_json(path: String) -> Variant:
	if not FileAccess.file_exists(path):
		push_error("No se encontró el catálogo: " + path)
		return null
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("No se pudo abrir el catálogo: " + path)
		return null
	var parsed: Variant = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY or int(parsed.get("version", 0)) != 1:
		push_error("El catálogo tiene un formato o versión no compatible: " + path)
		return null
	return parsed

static func get_roots() -> Array[Dictionary]:
	var parsed: Variant = _read_json(ROOTS_PATH)
	if parsed == null:
		return []
	var entries: Variant = parsed.get("roots", [])
	if typeof(entries) != TYPE_ARRAY or entries.size() != 7:
		push_error("El catálogo debe contener exactamente siete raíces.")
		return []
	var roots: Array[Dictionary] = []
	var seen_ids := {}
	for entry in entries:
		if typeof(entry) != TYPE_DICTIONARY or not entry.has("id") or not entry.has("name") or not entry.has("description"):
			push_error("Se encontró una entrada de raíz incompleta.")
			return []
		if seen_ids.has(entry["id"]):
			push_error("Se encontró un ID de raíz duplicado: " + str(entry["id"]))
			return []
		seen_ids[entry["id"]] = true
		roots.append(entry)
	return roots

static func get_entries(category: String) -> Array[Dictionary]:
	if not CATALOG_PATHS.has(category):
		push_error("Categoría de catálogo desconocida: " + category)
		return []
	var parsed: Variant = _read_json(CATALOG_PATHS[category])
	if parsed == null:
		return []
	var entries: Variant = parsed.get("items", [])
	if typeof(entries) != TYPE_ARRAY:
		push_error("El catálogo debe contener una lista de elementos: " + category)
		return []
	var result: Array[Dictionary] = []
	var seen_ids := {}
	for entry in entries:
		if typeof(entry) != TYPE_DICTIONARY or not entry.has("id") or not entry.has("name") or not entry.has("status") or not entry.has("summary"):
			push_error("Se encontró una entrada incompleta en " + category)
			return []
		if not EDITORIAL_STATUSES.has(str(entry["status"])):
			push_error("Estado editorial desconocido en " + category + ": " + str(entry["status"]))
			return []
		if seen_ids.has(entry["id"]):
			push_error("ID duplicado en el catálogo " + category + ": " + str(entry["id"]))
			return []
		seen_ids[entry["id"]] = true
		result.append(entry)
	return result

static func validate_all_catalogs() -> bool:
	var roots := get_roots()
	if roots.size() != 7:
		return false
	var all_ids := {}
	for root in roots:
		all_ids[root["id"]] = true
	for category in CATALOG_PATHS.keys():
		var parsed: Variant = _read_json(CATALOG_PATHS[category])
		if parsed == null:
			return false
		var raw_items: Variant = parsed.get("items", null)
		if typeof(raw_items) != TYPE_ARRAY:
			push_error("Colección items ausente o inválida: " + category)
			return false
		var entries := get_entries(category)
		if entries.size() != raw_items.size():
			return false
		for entry in entries:
			if all_ids.has(entry["id"]):
				push_error("ID global duplicado: " + str(entry["id"]))
				return false
			all_ids[entry["id"]] = true
	return true
