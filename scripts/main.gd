extends Control

const WORLD_DATA = preload("res://scripts/world_data.gd")
const SAVE_PATH := "user://siete_raices_save.json"

var screen_root: Control
var character: Dictionary = {}

func _ready() -> void:
	if not WORLD_DATA.validate_all_catalogs():
		push_error("Los catálogos de Siete Raíces no superaron la validación.")
	_build_shell()
	if _load_character():
		_show_dashboard()
	else:
		_show_menu()

func _build_shell() -> void:
	var background := ColorRect.new()
	background.color = Color("#080b13")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)
	var glow := ColorRect.new()
	glow.color = Color("#171b2b")
	glow.position = Vector2(700, 80)
	glow.size = Vector2(480, 480)
	glow.modulate.a = 0.34
	add_child(glow)
	screen_root = Control.new()
	screen_root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(screen_root)

func _clear_screen() -> void:
	for child in screen_root.get_children():
		screen_root.remove_child(child)
		child.queue_free()

func _make_layout() -> VBoxContainer:
	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var side_margin := 24 if get_viewport_rect().size.x < 800 else 56
	margin.add_theme_constant_override("margin_left", side_margin)
	margin.add_theme_constant_override("margin_right", side_margin)
	margin.add_theme_constant_override("margin_top", 38)
	margin.add_theme_constant_override("margin_bottom", 34)
	screen_root.add_child(margin)
	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	margin.add_child(scroll)
	var layout := VBoxContainer.new()
	layout.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	layout.add_theme_constant_override("separation", 16)
	scroll.add_child(layout)
	return layout

func _label(text: String, size: int = 16, color: String = "#e9e3d8") -> Label:
	var item := Label.new()
	item.text = text
	item.add_theme_font_size_override("font_size", size)
	item.add_theme_color_override("font_color", Color(color))
	item.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	return item

func _button(text: String, callback: Callable) -> Button:
	var item := Button.new()
	item.text = text
	item.custom_minimum_size = Vector2(190, 46)
	item.add_theme_font_size_override("font_size", 11)
	item.add_theme_color_override("font_color", Color("#e8d4ad"))
	var normal := StyleBoxFlat.new()
	normal.bg_color = Color("#121827")
	normal.border_color = Color("#b99760")
	normal.set_border_width_all(1)
	normal.set_corner_radius_all(4)
	normal.content_margin_left = 12
	normal.content_margin_right = 12
	var hover := normal.duplicate() as StyleBoxFlat
	hover.bg_color = Color("#202a3d")
	var pressed := normal.duplicate() as StyleBoxFlat
	pressed.bg_color = Color("#3a2f20")
	item.add_theme_stylebox_override("normal", normal)
	item.add_theme_stylebox_override("hover", hover)
	item.add_theme_stylebox_override("pressed", pressed)
	item.add_theme_stylebox_override("focus", hover)
	item.pressed.connect(callback)
	return item

func _show_menu() -> void:
	_clear_screen()
	var layout := _make_layout()
	layout.add_child(_label("✧   SIETE RAÍCES  /  ARCHIVO DE LO PRIMORDIAL", 13, "#d6b77f"))
	var spacer := Control.new()
	spacer.custom_minimum_size.y = 55
	layout.add_child(spacer)
	layout.add_child(_label("UN UNIVERSO ORIGINAL DE CULTIVO", 12, "#c4a575"))
	layout.add_child(_label("El destino no se hereda.\nSe conquista.", 46, "#f0e9dc"))
	layout.add_child(_label("Siete raíces sostienen la existencia. Tu camino comienza con una decisión, no con una profecía.", 17, "#a6a7b1"))
	var actions := HBoxContainer.new()
	actions.add_theme_constant_override("separation", 12)
	layout.add_child(actions)
	actions.add_child(_button("INICIAR CAMINO", _show_creation))
	actions.add_child(_button("VER LAS SIETE RAÍCES", _show_codex))
	layout.add_child(_label("PROTOTIPO JUGABLE · CREACIÓN DE PERSONAJE Y PRIMERAS PRÁCTICAS", 10, "#888b98"))
	var filler := Control.new()
	filler.size_flags_vertical = Control.SIZE_EXPAND_FILL
	layout.add_child(filler)
	layout.add_child(_label("NINGÚN PERSONAJE TIENE GARANTIZADA LA GRANDEZA.", 11, "#c7a878"))

func _show_creation() -> void:
	_clear_screen()
	var layout := _make_layout()
	layout.add_child(_label("SIETE RAÍCES  /  CEREMONIA DE INICIO", 12, "#d6b77f"))
	layout.add_child(_label("Define tu primer camino", 38))
	layout.add_child(_label("Tus elecciones describen el comienzo. No determinan hasta dónde podrás llegar.", 15, "#a6a7b1"))
	var name_input := LineEdit.new()
	name_input.placeholder_text = "Nombre de tu cultivador"
	name_input.custom_minimum_size.y = 44
	name_input.add_theme_color_override("font_color", Color("#eee8dc"))
	name_input.add_theme_color_override("font_placeholder_color", Color("#858b99"))
	layout.add_child(_label("NOMBRE", 11, "#c4a575"))
	layout.add_child(name_input)
	var origin_select := OptionButton.new()
	for origin in ["Continentes Mortales", "Dominio de las Sectas", "Mar de los Antiguos"]:
		origin_select.add_item(origin)
	origin_select.select(0)
	layout.add_child(_label("PROCEDENCIA", 11, "#c4a575"))
	layout.add_child(origin_select)
	var root_select := OptionButton.new()
	for root in WORLD_DATA.get_roots():
		root_select.add_item(root["name"])
	root_select.select(0)
	layout.add_child(_label("AFINIDAD INICIAL", 11, "#c4a575"))
	layout.add_child(root_select)
	var path_select := OptionButton.new()
	for path in WORLD_DATA.CULTIVATION_PATHS:
		path_select.add_item(path)
	path_select.select(0)
	layout.add_child(_label("CAMINO DE CULTIVO", 11, "#c4a575"))
	layout.add_child(path_select)
	var actions := VBoxContainer.new()
	actions.add_theme_constant_override("separation", 10)
	layout.add_child(actions)
	actions.add_child(_button("DESPERTAR MI CAMINO", func():
		var chosen_name := name_input.text.strip_edges()
		if chosen_name.is_empty():
			name_input.placeholder_text = "Escribe un nombre para continuar"
			return
		character = {
			"name": chosen_name,
			"origin": origin_select.get_item_text(origin_select.selected),
			"affinity": root_select.get_item_text(root_select.selected),
			"path": path_select.get_item_text(path_select.selected),
			"comprehension": 1,
			"vitality": 1,
			"insight": 0,
			"realm": "Despertar",
		}
		_save_character()
		_show_dashboard()
	))
	actions.add_child(_button("VOLVER", _show_menu))

func _show_dashboard() -> void:
	_clear_screen()
	var layout := _make_layout()
	layout.add_child(_label("SIETE RAÍCES  /  REGISTRO DEL CULTIVADOR", 12, "#d6b77f"))
	layout.add_child(_label(str(character.get("name", "Cultivador")), 40))
	layout.add_child(_label("%s  ·  Afinidad: %s  ·  Camino: %s" % [character.get("origin", ""), character.get("affinity", ""), character.get("path", "")], 14, "#c4a575"))
	layout.add_child(_label("REINO ACTUAL  ·  %s" % character.get("realm", "Despertar"), 12, "#a6a7b1"))
	var stats := HBoxContainer.new()
	stats.add_theme_constant_override("separation", 20)
	layout.add_child(stats)
	stats.add_child(_label("COMPRENSIÓN\n%s" % character.get("comprehension", 1), 18, "#e4c58e"))
	stats.add_child(_label("VITALIDAD\n%s" % character.get("vitality", 1), 18, "#9eb6d5"))
	stats.add_child(_label("HALLAZGOS\n%s" % character.get("insight", 0), 18, "#b8a4d9"))
	layout.add_child(_label("PRÁCTICAS INICIALES", 11, "#c4a575"))
	layout.add_child(_label("Cada práctica desarrolla una dimensión distinta. El progreso se guarda en este dispositivo.", 14, "#a6a7b1"))
	var actions := HBoxContainer.new()
	actions.add_theme_constant_override("separation", 10)
	layout.add_child(actions)
	actions.add_child(_button("MEDITAR  +1 COMPRENSIÓN", func():
		character["comprehension"] = int(character.get("comprehension", 1)) + 1
		_save_character()
		_show_dashboard()
	))
	actions.add_child(_button("ENTRENAR  +1 VITALIDAD", func():
		character["vitality"] = int(character.get("vitality", 1)) + 1
		_save_character()
		_show_dashboard()
	))
	var second_row := HBoxContainer.new()
	second_row.add_theme_constant_override("separation", 10)
	layout.add_child(second_row)
	second_row.add_child(_button("EXPLORAR  +1 HALLAZGO", func():
		character["insight"] = int(character.get("insight", 0)) + 1
		_save_character()
		_show_dashboard()
	))
	second_row.add_child(_button("CONSULTAR LAS RAÍCES", _show_codex))
	layout.add_child(_button("REINICIAR PERSONAJE", _confirm_reset))
	var filler := Control.new()
	filler.size_flags_vertical = Control.SIZE_EXPAND_FILL
	layout.add_child(filler)
	layout.add_child(_label("GUARDADO LOCAL · user://siete_raices_save.json", 10, "#777d8c"))

func _show_codex() -> void:
	_clear_screen()
	var layout := _make_layout()
	layout.add_child(_label("ARCHIVO DE LO PRIMORDIAL  /  CÓDICE", 12, "#d6b77f"))
	layout.add_child(_label("Las siete raíces", 38))
	for root in WORLD_DATA.get_roots():
		var block := VBoxContainer.new()
		block.add_theme_constant_override("separation", 4)
		block.add_child(_label(str(root["name"]).to_upper(), 14, "#e4c58e"))
		block.add_child(_label(str(root["description"]), 13, "#a6a7b1"))
		layout.add_child(block)
	layout.add_child(_button("VOLVER", func():
		if character.is_empty():
			_show_menu()
		else:
			_show_dashboard()
	))

func _confirm_reset() -> void:
	var dialog := ConfirmationDialog.new()
	dialog.dialog_text = "¿Crear un nuevo cultivador? El registro local actual será reemplazado."
	add_child(dialog)
	dialog.confirmed.connect(func():
		character.clear()
		if FileAccess.file_exists(SAVE_PATH):
			DirAccess.remove_absolute(ProjectSettings.globalize_path(SAVE_PATH))
		_show_creation()
		dialog.queue_free()
	)
	dialog.canceled.connect(func(): dialog.queue_free())
	dialog.popup_centered()

func _save_character() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(character))

func _load_character() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		return false
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		return false
	var parsed = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY or not parsed.has("name"):
		return false
	character = parsed
	return true
