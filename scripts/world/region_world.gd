extends Node3D

const WORLD_DATA = preload("res://scripts/world_data.gd")
const HUMANOID_CONTROLLER = preload("res://scripts/characters/humanoid_controller.gd")
const CAMERA_RIG = preload("res://scripts/characters/three_quarter_camera_rig.gd")
const SAVE_PATH := "user://siete_raices_save.json"

@export var region_id: String = "region_mortal_continents"

var _region: Dictionary = {}
var _status_label: Label


func _ready() -> void:
	for entry in WORLD_DATA.get_entries("regions"):
		if str(entry.get("id", "")) == region_id:
			_region = entry
			break
	if _region.is_empty():
		push_error("No se encontró la región: " + region_id)
		return
	_build_environment()
	_build_landmarks()
	_build_player()
	_build_hud()


func _build_environment() -> void:
	var palette: Dictionary = _region.get("palette", {})
	var sky := Color(str(palette.get("sky", "#526070")))
	var ground := Color(str(palette.get("ground", "#384b45")))
	var accent := Color(str(palette.get("accent", "#d4b477")))

	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = sky
	environment.ambient_light_color = sky.lightened(0.25)
	environment.ambient_light_energy = 0.7
	var world_environment := WorldEnvironment.new()
	world_environment.environment = environment
	add_child(world_environment)

	var sunlight := DirectionalLight3D.new()
	sunlight.rotation_degrees = Vector3(-48.0, -32.0, 0.0)
	sunlight.light_color = Color("#ffe8c5")
	sunlight.light_energy = 1.1
	sunlight.shadow_enabled = true
	add_child(sunlight)

	var ground_mesh := PlaneMesh.new()
	ground_mesh.size = Vector2(90.0, 90.0)
	_add_mesh(ground_mesh, _make_material(ground), Vector3.ZERO)

	for index in range(4):
		var hill := SphereMesh.new()
		_add_mesh(hill, _make_material(ground.lightened(0.12)), Vector3(-18.0 + index * 12.0, -1.0, -19.0 - (index % 2) * 5.0), Vector3(7.0, 1.7, 5.0))

	for index in range(5):
		_add_column(Vector3(-12.0 + index * 6.0, 0.0, -8.0), 0.8, 3.4, _make_material(accent.darkened(0.25)))


func _build_landmarks() -> void:
	var palette: Dictionary = _region.get("palette", {})
	var accent := Color(str(palette.get("accent", "#d4b477")))
	var stone := _make_material(Color("#8b8d91"))
	var glow := _make_material(accent, true)

	match region_id:
		"region_mortal_continents":
			for point in [Vector3(-14, 0, 7), Vector3(-7, 0, 12), Vector3(8, 0, 8), Vector3(15, 0, 13)]:
				_add_tree(point, 1.0, stone, glow)
			_add_arch(Vector3(0, 0, -5), stone, 4.5)
		"region_sect_domains":
			for x in [-12.0, -6.0, 6.0, 12.0]:
				_add_column(Vector3(x, 0, -4), 0.65, 6.0, stone)
			for step in range(5):
				var stair := BoxMesh.new()
				stair.size = Vector3(8.0, 0.35, 1.1)
				_add_mesh(stair, stone, Vector3(0, 0.18 + step * 0.25, 7.0 - step * 1.0))
			for x in [-8.0, 0.0, 8.0]:
				_add_mesh(SphereMesh.new(), glow, Vector3(x, 3.4, -3), Vector3(0.28, 0.28, 0.28))
		"region_ancient_sea":
			var water := PlaneMesh.new()
			water.size = Vector2(80, 80)
			_add_mesh(water, _make_material(Color("#245c78")), Vector3(0, -0.08, 0))
			for point in [Vector3(-13, 1.2, -8), Vector3(0, 2.0, -15), Vector3(13, 1.0, -6), Vector3(8, 0.8, 12)]:
				_add_mesh(SphereMesh.new(), _make_material(Color("#627e80")), point, Vector3(4.0, 0.9, 3.0))
				_add_column(point + Vector3(0, 1.5, 0), 0.45, 3.0, glow)
		"region_fragmented_heavens":
			for index in range(6):
				var point := Vector3(-15.0 + index * 6.0, 2.0 + float(index % 3) * 2.0, -12.0 - float(index % 2) * 5.0)
				_add_mesh(SphereMesh.new(), _make_material(Color("#6d648b")), point, Vector3(3.2, 0.75, 2.6))
				_add_column(point + Vector3(0, 1.0, 0), 0.35, 2.0, glow)
			_add_arch(Vector3(0, 0, 3), glow, 3.2)
		"region_root_domain":
			_add_column(Vector3(0, 0, -8), 1.2, 13.0, glow)
			_add_mesh(SphereMesh.new(), _make_material(Color("#668d69"), true), Vector3(0, 7.5, -8), Vector3(5.5, 4.2, 5.5))
			for index in range(7):
				var angle := TAU * float(index) / 7.0
				var point := Vector3(cos(angle) * 9.0, 0.3, -8.0 + sin(angle) * 9.0)
				_add_mesh(SphereMesh.new(), glow, point, Vector3(0.55, 0.55, 0.55))
				_add_column(point, 0.22, 2.2, stone)


func _build_player() -> void:
	var player := CharacterBody3D.new()
	player.name = "Player"
	player.position = Vector3(0, 0.05, 5)
	player.set_script(HUMANOID_CONTROLLER)

	var collision := CollisionShape3D.new()
	collision.position.y = 0.9
	var capsule_shape := CapsuleShape3D.new()
	capsule_shape.radius = 0.34
	capsule_shape.height = 1.8
	collision.shape = capsule_shape
	player.add_child(collision)

	var robe := MeshInstance3D.new()
	robe.position.y = 0.88
	var robe_mesh := CapsuleMesh.new()
	robe_mesh.radius = 0.32
	robe_mesh.height = 1.35
	robe.mesh = robe_mesh
	robe.material_override = _make_material(Color("#d7c6a2"))
	player.add_child(robe)

	var head := MeshInstance3D.new()
	head.position.y = 1.72
	var head_mesh := SphereMesh.new()
	head_mesh.radius = 0.22
	head.mesh = head_mesh
	head.material_override = _make_material(Color("#d8b89a"))
	player.add_child(head)

	add_child(player)

	var camera_rig := Node3D.new()
	camera_rig.name = "CameraRig"
	camera_rig.set_script(CAMERA_RIG)
	var camera := Camera3D.new()
	camera.name = "Camera3D"
	camera.fov = 42.0
	camera_rig.add_child(camera)
	add_child(camera_rig)


func _build_hud() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var panel := PanelContainer.new()
	panel.position = Vector2(22, 22)
	panel.custom_minimum_size = Vector2(460, 170)
	layer.add_child(panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 18)
	margin.add_theme_constant_override("margin_right", 18)
	margin.add_theme_constant_override("margin_top", 14)
	margin.add_theme_constant_override("margin_bottom", 14)
	panel.add_child(margin)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 8)
	margin.add_child(layout)

	var title := Label.new()
	title.text = str(_region.get("name", "Región desconocida")).to_upper()
	title.add_theme_font_size_override("font_size", 17)
	title.add_theme_color_override("font_color", Color("#e8d3a6"))
	layout.add_child(title)

	var description := Label.new()
	description.text = str(_region.get("summary", "Explora y descubre este lugar."))
	description.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	description.add_theme_font_size_override("font_size", 12)
	description.add_theme_color_override("font_color", Color("#d2d6df"))
	layout.add_child(description)

	_status_label = Label.new()
	_status_label.text = "WASD: moverte  ·  SHIFT: correr  ·  ESPACIO: saltar"
	_status_label.add_theme_font_size_override("font_size", 11)
	_status_label.add_theme_color_override("font_color", Color("#b5c2d2"))
	layout.add_child(_status_label)

	var buttons := HBoxContainer.new()
	buttons.add_theme_constant_override("separation", 8)
	layout.add_child(buttons)

	var discovery := Button.new()
	discovery.text = "REGISTRAR DESCUBRIMIENTO"
	discovery.pressed.connect(_record_discovery)
	buttons.add_child(discovery)

	var back := Button.new()
	back.text = "VOLVER AL CAMPAMENTO"
	back.pressed.connect(_return_to_dashboard)
	buttons.add_child(back)


func _record_discovery() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		_status_label.text = "Crea primero tu personaje para guardar el descubrimiento."
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		_status_label.text = "No se pudo leer el registro local."
		return
	var data: Variant = JSON.parse_string(file.get_as_text())
	if typeof(data) != TYPE_DICTIONARY:
		_status_label.text = "El registro del cultivador no es válido."
		return
	var discovered: Array = data.get("discovered_regions", [])
	if discovered.has(region_id):
		_status_label.text = "Este lugar ya está registrado en tu códice."
		return
	discovered.append(region_id)
	data["discovered_regions"] = discovered
	data["insight"] = int(data.get("insight", 0)) + 1
	data["comprehension"] = int(data.get("comprehension", 1)) + 1
	var output := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if output:
		output.store_string(JSON.stringify(data))
		_status_label.text = "Descubrimiento registrado. +1 hallazgo · +1 comprensión."


func _return_to_dashboard() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _make_material(color: Color, emissive: bool = false) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = 0.82
	if emissive:
		material.emission_enabled = true
		material.emission = color
		material.emission_energy_multiplier = 1.1
	return material


func _add_mesh(mesh: Mesh, material: Material, position: Vector3, scale: Vector3 = Vector3.ONE) -> void:
	var instance := MeshInstance3D.new()
	instance.mesh = mesh
	instance.material_override = material
	instance.position = position
	instance.scale = scale
	add_child(instance)


func _add_column(position: Vector3, radius: float, height: float, material: Material) -> void:
	var mesh := CylinderMesh.new()
	mesh.top_radius = radius
	mesh.bottom_radius = radius * 1.12
	mesh.height = height
	_add_mesh(mesh, material, position + Vector3.UP * (height * 0.5))


func _add_tree(position: Vector3, scale_factor: float, trunk_material: Material, canopy_material: Material) -> void:
	var trunk := CylinderMesh.new()
	trunk.top_radius = 0.18 * scale_factor
	trunk.bottom_radius = 0.28 * scale_factor
	trunk.height = 2.4 * scale_factor
	_add_mesh(trunk, trunk_material, position + Vector3.UP * (1.2 * scale_factor))
	_add_mesh(SphereMesh.new(), canopy_material, position + Vector3.UP * (2.8 * scale_factor), Vector3(1.25, 1.5, 1.25) * scale_factor)


func _add_arch(position: Vector3, material: Material, height: float) -> void:
	_add_column(position + Vector3(-2.2, 0, 0), 0.32, height, material)
	_add_column(position + Vector3(2.2, 0, 0), 0.32, height, material)
	var beam := BoxMesh.new()
	beam.size = Vector3(5.0, 0.55, 0.8)
	_add_mesh(beam, material, position + Vector3(0, height, 0))
