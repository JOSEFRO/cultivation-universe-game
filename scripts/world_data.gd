extends RefCounted
class_name WorldData

const ROOTS_PATH := "res://data/roots.json"
const CULTIVATION_PATHS := ["Cuerpo", "Alma", "Leyes", "Ruptura"]
const WORLD_PRINCIPLE := "Ningún cultivador tiene garantizada la grandeza por su nacimiento, talento o maestro."

static func get_roots() -> Array[Dictionary]:
	if not FileAccess.file_exists(ROOTS_PATH):
		push_error("No se encontró el catálogo de raíces: " + ROOTS_PATH)
		return []
	var file := FileAccess.open(ROOTS_PATH, FileAccess.READ)
	if file == null:
		push_error("No se pudo abrir el catálogo de raíces.")
		return []
	var parsed: Variant = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY or int(parsed.get("version", 0)) != 1:
		push_error("El catálogo de raíces tiene un formato o versión no compatible.")
		return []
	var entries: Variant = parsed.get("roots", [])
	if typeof(entries) != TYPE_ARRAY or entries.size() != 7:
		push_error("El catálogo debe contener exactamente siete raíces.")
		return []
	var roots: Array[Dictionary] = []
	for entry in entries:
		if typeof(entry) != TYPE_DICTIONARY or not entry.has("id") or not entry.has("name") or not entry.has("description"):
			push_error("Se encontró una entrada de raíz incompleta.")
			return []
		roots.append(entry)
	return roots
