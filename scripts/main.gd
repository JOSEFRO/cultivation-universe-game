extends Control

const WORLD_DATA = preload("res://scripts/world_data.gd")

var status_label: Label

func _ready() -> void:
	_build_interface()

func _build_interface() -> void:
	var background := ColorRect.new()
	background.color = Color("#090b12")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)

	var glow := ColorRect.new()
	glow.color = Color("#17182a")
	glow.position = Vector2(760, 70)
	glow.size = Vector2(440, 440)
	glow.modulate.a = 0.48
	add_child(glow)

	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 72)
	margin.add_theme_constant_override("margin_right", 72)
	margin.add_theme_constant_override("margin_top", 48)
	margin.add_theme_constant_override("margin_bottom", 40)
	add_child(margin)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 22)
	margin.add_child(layout)

	var brand := Label.new()
	brand.text = "✧   SIETE RAÍCES     /     ARCHIVO DE LO PRIMORDIAL"
	brand.add_theme_font_size_override("font_size", 14)
	brand.add_theme_color_override("font_color", Color("#d6b77f"))
	layout.add_child(brand)

	var spacer := Control.new()
	spacer.custom_minimum_size.y = 75
	layout.add_child(spacer)

	var eyebrow := Label.new()
	eyebrow.text = "UN UNIVERSO ORIGINAL DE CULTIVO"
	eyebrow.add_theme_font_size_override("font_size", 12)
	eyebrow.add_theme_color_override("font_color", Color("#c4a575"))
	layout.add_child(eyebrow)

	var title := Label.new()
	title.text = "El destino no se hereda.\nSe conquista."
	title.add_theme_font_size_override("font_size", 48)
	title.add_theme_color_override("font_color", Color("#f0e9dc"))
	layout.add_child(title)

	var description := Label.new()
	description.text = "Siete raíces sostienen la existencia. Infinitos caminos esperan a quienes se atrevan a comprenderlas."
	description.custom_minimum_size.x = 540
	description.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	description.add_theme_font_size_override("font_size", 17)
	description.add_theme_color_override("font_color", Color("#a6a7b1"))
	layout.add_child(description)

	var gap := Control.new()
	gap.custom_minimum_size.y = 18
	layout.add_child(gap)

	var buttons := HBoxContainer.new()
	buttons.add_theme_constant_override("separation", 14)
	layout.add_child(buttons)

	var begin_button := Button.new()
	begin_button.text = "  INICIAR CAMINO  "
	begin_button.custom_minimum_size = Vector2(190, 48)
	begin_button.pressed.connect(_on_begin_pressed)
	buttons.add_child(begin_button)

	var codex_button := Button.new()
	codex_button.text = "  VER LAS SIETE RAÍCES  "
	codex_button.custom_minimum_size = Vector2(210, 48)
	codex_button.pressed.connect(_on_codex_pressed)
	buttons.add_child(codex_button)

	status_label = Label.new()
	status_label.text = "PROTOTIPO 0.1.0  ·  EL VIAJE AÚN NO HA COMENZADO"
	status_label.add_theme_font_size_override("font_size", 11)
	status_label.add_theme_color_override("font_color", Color("#888b98"))
	layout.add_child(status_label)

	var bottom_spacer := Control.new()
	bottom_spacer.size_flags_vertical = Control.SIZE_EXPAND_FILL
	layout.add_child(bottom_spacer)

	var principle := Label.new()
	principle.text = "NINGÚN PERSONAJE TIENE GARANTIZADA LA GRANDEZA."
	principle.add_theme_font_size_override("font_size", 11)
	principle.add_theme_color_override("font_color", Color("#c7a878"))
	layout.add_child(principle)

func _on_begin_pressed() -> void:
	status_label.text = "CREACIÓN DE PERSONAJE: PRÓXIMO MÓDULO EN DESARROLLO"

func _on_codex_pressed() -> void:
	var names: Array[String] = []
	for root in WORLD_DATA.ROOTS:
		names.append(root["name"])
	status_label.text = "RAÍCES: " + " · ".join(names)
