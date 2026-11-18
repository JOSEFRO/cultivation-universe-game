extends Control

const WORLD_DATA = preload("res://scripts/world_data.gd")

var status_label: Label

func _ready() -> void:
	_build_interface()

func _build_interface() -> void:
	var gradient := Gradient.new()
	gradient.colors = [Color("#050912"), Color("#101d32"), Color("#080d18")]
	gradient.offsets = PackedFloat32Array([0.0, 0.56, 1.0])
	var gradient_texture := GradientTexture2D.new()
	gradient_texture.gradient = gradient
	gradient_texture.fill_from = Vector2(0.0, 0.0)
	gradient_texture.fill_to = Vector2(1.0, 1.0)
	var background := TextureRect.new()
	background.texture = gradient_texture
	background.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	background.stretch_mode = TextureRect.STRETCH_SCALE
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)

	_add_starfield()
	_add_orbit(790, 310, 470, 470, Color("#d9b77c", 0.30), -0.12)
	_add_orbit(790, 310, 360, 360, Color("#8adce5", 0.24), 0.16)
	_add_orbit(790, 310, 255, 255, Color("#d9b77c", 0.20), -0.22)
	_add_mountain_layer(0, 460, 1280, 260, Color("#0a1728"))
	_add_mountain_layer(0, 520, 1280, 200, Color("#0c2030"))
	_add_mountain_layer(0, 590, 1280, 130, Color("#101d2b"))

	var vignette := ColorRect.new()
	vignette.color = Color(0.01, 0.02, 0.04, 0.24)
	vignette.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	vignette.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(vignette)

	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 72)
	margin.add_theme_constant_override("margin_right", 72)
	margin.add_theme_constant_override("margin_top", 38)
	margin.add_theme_constant_override("margin_bottom", 34)
	add_child(margin)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 18)
	margin.add_child(layout)

	var header := HBoxContainer.new()
	layout.add_child(header)
	var brand := Label.new()
	brand.text = "✧   SIETE RAÍCES"
	brand.add_theme_font_size_override("font_size", 16)
	brand.add_theme_color_override("font_color", Color("#e8c78c"))
	header.add_child(brand)
	var header_spacer := Control.new()
	header_spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header.add_child(header_spacer)
	var edition := Label.new()
	edition.text = "ARCHIVO DE LO PRIMORDIAL   /   PROTOTIPO 0.1"
	edition.add_theme_font_size_override("font_size", 10)
	edition.add_theme_color_override("font_color", Color("#8ea7bd"))
	header.add_child(edition)

	var content_spacer := Control.new()
	content_spacer.size_flags_vertical = Control.SIZE_EXPAND_FILL
	layout.add_child(content_spacer)

	var eyebrow := Label.new()
	eyebrow.text = "UN UNIVERSO ORIGINAL DE CULTIVO"
	eyebrow.add_theme_font_size_override("font_size", 11)
	eyebrow.add_theme_color_override("font_color", Color("#9fe1e5"))
	layout.add_child(eyebrow)

	var title := Label.new()
	title.text = "El destino no se hereda.\nSe conquista."
	title.add_theme_font_size_override("font_size", 54)
	title.add_theme_color_override("font_color", Color("#f5eee2"))
	layout.add_child(title)

	var description := Label.new()
	description.text = "Siete raíces sostienen la existencia. Infinitos caminos esperan a quienes se atrevan a comprenderlas."
	description.custom_minimum_size.x = 540
	description.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	description.add_theme_font_size_override("font_size", 16)
	description.add_theme_color_override("font_color", Color("#b2bdc9"))
	layout.add_child(description)

	var gap := Control.new()
	gap.custom_minimum_size.y = 8
	layout.add_child(gap)

	var buttons := HBoxContainer.new()
	buttons.add_theme_constant_override("separation", 12)
	layout.add_child(buttons)

	var begin_button := Button.new()
	begin_button.text = "  INICIAR CAMINO  "
	begin_button.custom_minimum_size = Vector2(190, 48)
	begin_button.add_theme_color_override("font_color", Color("#07111a"))
	begin_button.add_theme_stylebox_override("normal", _button_style(Color("#e8c78c"), Color("#f4d9a5")))
	begin_button.add_theme_stylebox_override("hover", _button_style(Color("#f5dca9"), Color("#fff0cc")))
	begin_button.add_theme_stylebox_override("pressed", _button_style(Color("#c6a36d"), Color("#e8c78c")))
	begin_button.pressed.connect(_on_begin_pressed)
	buttons.add_child(begin_button)

	var codex_button := Button.new()
	codex_button.text = "  VER LAS SIETE RAÍCES  "
	codex_button.custom_minimum_size = Vector2(220, 48)
	codex_button.add_theme_color_override("font_color", Color("#e9e5dc"))
	codex_button.add_theme_stylebox_override("normal", _button_style(Color("#15283b"), Color("#587b8d")))
	codex_button.add_theme_stylebox_override("hover", _button_style(Color("#1d3a4d"), Color("#9fe1e5")))
	codex_button.pressed.connect(_on_codex_pressed)
	buttons.add_child(codex_button)

	status_label = Label.new()
	status_label.text = "EL VIAJE AÚN NO HA COMENZADO"
	status_label.add_theme_font_size_override("font_size", 10)
	status_label.add_theme_color_override("font_color", Color("#91a8b7"))
	layout.add_child(status_label)

	var bottom_spacer := Control.new()
	bottom_spacer.size_flags_vertical = Control.SIZE_EXPAND_FILL
	layout.add_child(bottom_spacer)

	var footer := HBoxContainer.new()
	layout.add_child(footer)
	var principle := Label.new()
	principle.text = "NINGÚN PERSONAJE TIENE GARANTIZADA LA GRANDEZA."
	principle.add_theme_font_size_override("font_size", 10)
	principle.add_theme_color_override("font_color", Color("#c9ad7c"))
	footer.add_child(principle)
	var footer_spacer := Control.new()
	footer_spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	footer.add_child(footer_spacer)
	var footer_note := Label.new()
	footer_note.text = "EL CAMINO SE CULTIVA  ·  01 / 07"
	footer_note.add_theme_font_size_override("font_size", 9)
	footer_note.add_theme_color_override("font_color", Color("#75899c"))
	footer.add_child(footer_note)

func _button_style(fill: Color, border: Color) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = fill
	style.border_color = border
	style.set_border_width_all(1)
	style.set_corner_radius_all(7)
	style.content_margin_left = 14
	style.content_margin_right = 14
	style.content_margin_top = 9
	style.content_margin_bottom = 9
	return style

func _add_starfield() -> void:
	var positions := [
		Vector2(90, 150), Vector2(310, 110), Vector2(540, 205), Vector2(1120, 120),
		Vector2(1010, 245), Vector2(890, 80), Vector2(430, 350), Vector2(1180, 390),
		Vector2(170, 390), Vector2(650, 90), Vector2(760, 410), Vector2(1040, 520)
	]
	for i in range(positions.size()):
		var star := Label.new()
		star.text = "✦" if i % 3 == 0 else "·"
		star.position = positions[i]
		star.add_theme_font_size_override("font_size", 10 if i % 3 == 0 else 18)
		star.add_theme_color_override("font_color", Color("#d9c18e", 0.55 if i % 2 == 0 else 0.28))
		star.mouse_filter = Control.MOUSE_FILTER_IGNORE
		add_child(star)

func _add_orbit(center_x: float, center_y: float, width: float, height: float, tint: Color, angle: float) -> void:
	var ring := Panel.new()
	ring.position = Vector2(center_x - width / 2.0, center_y - height / 2.0)
	ring.size = Vector2(width, height)
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0, 0, 0, 0)
	style.border_color = tint
	style.set_border_width_all(1)
	style.set_corner_radius_all(int(min(width, height) / 2.0))
	ring.add_theme_stylebox_override("panel", style)
	ring.rotation = angle
	ring.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(ring)

func _add_mountain_layer(x: float, y: float, width: float, height: float, tint: Color) -> void:
	var mountain := Polygon2D.new()
	mountain.position = Vector2(x, y)
	mountain.polygon = PackedVector2Array([
		Vector2(0, height), Vector2(0, height * 0.65), Vector2(width * 0.16, height * 0.12),
		Vector2(width * 0.27, height * 0.56), Vector2(width * 0.43, height * 0.02),
		Vector2(width * 0.59, height * 0.61), Vector2(width * 0.76, height * 0.16),
		Vector2(width, height * 0.52), Vector2(width, height)
	])
	mountain.color = tint
	add_child(mountain)

func _on_begin_pressed() -> void:
	status_label.text = "CREACIÓN DE PERSONAJE: PRÓXIMO MÓDULO EN DESARROLLO"

func _on_codex_pressed() -> void:
	var names: Array[String] = []
	for root in WORLD_DATA.ROOTS:
		names.append(root["name"])
	status_label.text = "RAÍCES: " + " · ".join(names)
