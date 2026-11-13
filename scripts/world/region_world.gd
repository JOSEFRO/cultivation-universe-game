extends Node3D

const WORLD_DATA = preload("res://scripts/world_data.gd")
const HUMANOID_CONTROLLER = preload("res://scripts/characters/humanoid_controller.gd")
const CAMERA_RIG = preload("res://scripts/characters/three_quarter_camera_rig.gd")
const SAVE_PATH := "user://siete_raices_save.json"

@export var region_id: String = "region-mortal-continents"

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
	environment.background_mode = Environment.BG_SKY
	var sky_material := ProceduralSkyMaterial.new()
	sky_material.sky_top_color = sky.darkened(0.18)
	sky_material.sky_horizon_color = sky.lightened(0.24)
	sky_material.ground_bottom_color = ground.darkened(0.35)
	sky_material.ground_horizon_color = ground
	var sky_resource := Sky.new()
	sky_resource.sky_material = sky_material
	environment.sky = sky_resource
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color("#d7c5ad")
	environment.ambient_light_energy = 0.72
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.fog_enabled = true
	environment.fog_light_color = sky.lightened(0.32)
	environment.fog_density = 0.006
	var world_environment := WorldEnvironment.new()
	world_environment.environment = environment
	add_child(world_environment)

	var sunlight := DirectionalLight3D.new()
	sunlight.rotation_degrees = Vector3(-42.0, -28.0, 0.0)
	sunlight.light_color = Color("#ffe5c2")
	sunlight.light_energy = 1.25
	sunlight.shadow_enabled = true
	add_child(sunlight)

	var ground_mesh := PlaneMesh.new()
	ground_mesh.size = Vector2(100.0, 100.0)
	_add_mesh(ground_mesh, _make_material(ground), Vector3.ZERO)
	var floor_body := StaticBody3D.new()
	floor_body.name = "WalkableGround"
	var floor_collision := CollisionShape3D.new()
	var floor_shape := BoxShape3D.new()
	floor_shape.size = Vector3(100.0, 0.4, 100.0)
	floor_collision.shape = floor_shape
	floor_collision.position.y = -0.2
	floor_body.add_child(floor_collision)
	add_child(floor_body)

	# A clear stone path makes the playable route readable.
	var path_mesh := BoxMesh.new()
	path_mesh.size = Vector3(5.0, 0.12, 42.0)
	_add_mesh(path_mesh, _make_material(Color("#8c8170")), Vector3(0, 0.04, -5))
	for side in [-1.0, 1.0]:
		for index in range(8):
			_add_bamboo(Vector3(side * (8.0 + float(index % 2) * 1.5), 0, -19.0 + index * 5.0), 0.85 + float(index % 3) * 0.12)
	for index in range(5):
		_add_lantern(Vector3(-3.8 + index * 1.9, 0, -2.0 - float(index % 2) * 7.0), accent)
	_add_distant_mountain_ridge(ground.lightened(0.10))
func _build_landmarks() -> void:
	var palette: Dictionary = _region.get("palette", {})
	var accent := Color(str(palette.get("accent", "#d4b477")))
	var jade := _make_material(Color("#4d806d"))
	var stone := _make_material(Color("#8b8174"))
	var roof := _make_material(Color("#293f48"))
	var red := _make_material(Color("#8e3e35"))
	var gold := _make_material(accent, true)

	match region_id:
		"region-mortal-continents":
			_build_chinese_pavilion(Vector3(0, 0, -13), 1.25, red, roof, gold, stone)
			for point in [Vector3(-14, 0, 7), Vector3(-10, 0, -5), Vector3(12, 0, 8), Vector3(15, 0, -10)]:
				_add_tree(point, 1.1, stone, jade)
			_add_stone_bridge(Vector3(0, 0, 9), stone)
		"region-sect-domains":
			_build_chinese_pavilion(Vector3(0, 0, -14), 1.7, red, roof, gold, stone)
			_build_chinese_pavilion(Vector3(-13, 0, -4), 0.8, red, roof, gold, stone)
			_build_chinese_pavilion(Vector3(13, 0, -4), 0.8, red, roof, gold, stone)
			for step in range(8):
				var stair := BoxMesh.new()
				stair.size = Vector3(9.0, 0.28, 1.1)
				_add_mesh(stair, stone, Vector3(0, 0.14 + step * 0.22, 7.0 - step * 1.05))
			for x in [-8.0, 8.0]:
				_add_lantern(Vector3(x, 0, 4), accent)
		"region-ancient-sea":
			var water := PlaneMesh.new()
			water.size = Vector2(90, 90)
			var water_material := _make_material(Color("#28677c"))
			water_material.metallic = 0.25
			water_material.roughness = 0.24
			_add_mesh(water, water_material, Vector3(0, -0.12, 0))
			for point in [Vector3(-14, 0.7, -8), Vector3(0, 1.2, -17), Vector3(14, 0.8, -7), Vector3(9, 0.6, 12)]:
				_add_island(point, stone, jade)
			_build_chinese_pavilion(Vector3(0, 1.0, -16), 0.75, red, roof, gold, stone)
			_add_stone_bridge(Vector3(0, 0, 8), stone)
		"region-fragmented-heavens":
			for index in range(7):
				var point := Vector3(-18.0 + index * 6.0, 1.4 + float(index % 3) * 2.0, -13.0 - float(index % 2) * 5.0)
				_add_island(point, stone, jade)
				_add_bamboo(point + Vector3(0, 0.8, 0), 0.65)
			_build_chinese_pavilion(Vector3(0, 3.0, -13), 1.0, red, roof, gold, stone)
			_add_stone_bridge(Vector3(0, 0, 4), stone)
			for x in [-13.0, 13.0]:
				_add_lantern(Vector3(x, 1.0, 2), accent)
		"region-root-domain":
			_add_column(Vector3(0, 0, -10), 1.6, 15.0, gold)
			_add_mesh(SphereMesh.new(), _make_material(Color("#668d69"), true), Vector3(0, 8.5, -10), Vector3(7.0, 5.0, 7.0))
			_build_chinese_pavilion(Vector3(-12, 0, -8), 0.8, red, roof, gold, stone)
			_build_chinese_pavilion(Vector3(12, 0, -8), 0.8, red, roof, gold, stone)
			for index in range(9):
				var angle := TAU * float(index) / 9.0
				var point := Vector3(cos(angle) * 10.0, 0.3, -10.0 + sin(angle) * 10.0)
				_add_lantern(point, accent)
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

	_build_player_visual(player)

	add_child(player)

	var camera_rig := Node3D.new()
	camera_rig.name = "CameraRig"
	camera_rig.set_script(CAMERA_RIG)
	var camera := Camera3D.new()
	camera.name = "Camera3D"
	camera.fov = 42.0
	camera_rig.add_child(camera)
	add_child(camera_rig)


func _build_player_visual(player: CharacterBody3D) -> void:
	# Stylized original xianxia-inspired robe character built from Godot meshes.
	# The visual is separate from the CharacterBody3D, so movement/collision stay intact.
	var skin := _make_material(Color("#e0b99a"))
	var robe := _make_material(Color("#e8e0cf"))
	var inner_robe := _make_material(Color("#294d61"))
	var sash := _make_material(Color("#9b493e"))
	var hair := _make_material(Color("#171b25"))
	var gold := _make_material(Color("#c5a66d"), true)

	_add_mesh(CapsuleMesh.new(), robe, Vector3(0, 0.88, 0), Vector3(0.92, 1.22, 0.72))
	_add_mesh(SphereMesh.new(), skin, Vector3(0, 1.72, 0), Vector3(0.78, 0.9, 0.78))
	_add_mesh(SphereMesh.new(), hair, Vector3(0, 1.91, -0.02), Vector3(0.82, 0.56, 0.82))
	_add_mesh(SphereMesh.new(), hair, Vector3(0, 2.24, -0.12), Vector3(0.28, 0.36, 0.28))
	_add_mesh(CylinderMesh.new(), inner_robe, Vector3(0, 1.14, -0.015), Vector3(0.55, 0.95, 0.55))
	_add_mesh(CylinderMesh.new(), sash, Vector3(0, 1.15, 0), Vector3(0.99, 0.12, 0.99))
	# Long sleeves and layered robe panels.
	_add_mesh(CapsuleMesh.new(), robe, Vector3(-0.39, 1.20, 0), Vector3(0.43, 0.92, 0.48))
	_add_mesh(CapsuleMesh.new(), robe, Vector3(0.39, 1.20, 0), Vector3(0.43, 0.92, 0.48))
	_add_mesh(BoxMesh.new(), inner_robe, Vector3(-0.16, 0.64, -0.31), Vector3(0.24, 0.86, 0.06))
	_add_mesh(BoxMesh.new(), inner_robe, Vector3(0.16, 0.64, -0.31), Vector3(0.24, 0.86, 0.06))
	_add_mesh(CapsuleMesh.new(), hair, Vector3(0, 1.45, 0.31), Vector3(0.16, 1.25, 0.18))
	_add_mesh(SphereMesh.new(), gold, Vector3(0, 2.47, -0.12), Vector3(0.13, 0.09, 0.13))
	# Boots.
	_add_mesh(BoxMesh.new(), _make_material(Color("#342f35")), Vector3(-0.16, 0.12, -0.03), Vector3(0.32, 0.22, 0.48))
	_add_mesh(BoxMesh.new(), _make_material(Color("#342f35")), Vector3(0.16, 0.12, -0.03), Vector3(0.32, 0.22, 0.48))
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


func _add_bamboo(position: Vector3, scale_factor: float) -> void:
	var green := _make_material(Color("#3f7155"))
	var dark_green := _make_material(Color("#294f42"))
	for stalk in range(3):
		var offset := Vector3((stalk - 1) * 0.32, 0, (stalk % 2) * 0.18)
		var stem := CylinderMesh.new()
		stem.top_radius = 0.045 * scale_factor
		stem.bottom_radius = 0.07 * scale_factor
		stem.height = 5.0 * scale_factor
		_add_mesh(stem, green, position + offset + Vector3(0, 2.5 * scale_factor, 0))
		for joint in range(1, 5):
			_add_mesh(SphereMesh.new(), dark_green, position + offset + Vector3(0, joint * scale_factor, 0), Vector3(0.09, 0.055, 0.09) * scale_factor)
		for leaf in range(4):
			var leaf_mesh := SphereMesh.new()
			_add_mesh(leaf_mesh, green, position + offset + Vector3((leaf - 1.5) * 0.28, (2.2 + leaf * 0.48) * scale_factor, -0.18), Vector3(0.32, 0.055, 0.11) * scale_factor)


func _add_lantern(position: Vector3, accent: Color) -> void:
	var post := _make_material(Color("#513a30"))
	var red := _make_material(Color("#9b4035"))
	var glow := _make_material(accent, true)
	_add_column(position, 0.075, 2.4, post)
	_add_mesh(BoxMesh.new(), red, position + Vector3(0, 2.45, 0), Vector3(0.55, 0.55, 0.55))
	_add_mesh(BoxMesh.new(), glow, position + Vector3(0, 2.45, 0), Vector3(0.38, 0.42, 0.38))
	_add_mesh(CylinderMesh.new(), post, position + Vector3(0, 2.82, 0), Vector3(0.38, 0.08, 0.38))


func _build_chinese_pavilion(position: Vector3, scale_factor: float, red: Material, roof: Material, gold: Material, stone: Material) -> void:
	var base := BoxMesh.new()
	base.size = Vector3(9.0, 0.55, 7.0) * scale_factor
	_add_mesh(base, stone, position + Vector3(0, 0.28 * scale_factor, 0))
	for x in [-3.4, 3.4]:
		for z in [-2.5, 2.5]:
			_add_column(position + Vector3(x * scale_factor, 0.55 * scale_factor, z * scale_factor), 0.22 * scale_factor, 3.8 * scale_factor, red)
	var floor := BoxMesh.new()
	floor.size = Vector3(8.0, 0.18, 6.0) * scale_factor
	_add_mesh(floor, _make_material(Color("#a78a69")), position + Vector3(0, 0.72 * scale_factor, 0))
	# Four sloped eaves form a recognizable Chinese hip roof silhouette.
	for side in range(4):
		var eave := BoxMesh.new()
		eave.size = Vector3(9.8, 0.28, 2.35) * scale_factor
		var angle := float(side) * PI * 0.5
		var offset := Vector3(cos(angle) * 1.8, 4.15, sin(angle) * 1.8) * scale_factor
		var piece := MeshInstance3D.new()
		piece.mesh = eave
		piece.material_override = roof
		piece.position = position + offset
		piece.rotation = Vector3(0, angle, -0.18)
		add_child(piece)
	var ridge := BoxMesh.new()
	ridge.size = Vector3(5.4, 0.32, 0.42) * scale_factor
	_add_mesh(ridge, gold, position + Vector3(0, 4.45 * scale_factor, 0))
	for x in [-2.4, 2.4]:
		_add_mesh(SphereMesh.new(), gold, position + Vector3(x * scale_factor, 4.5 * scale_factor, 0), Vector3(0.22, 0.18, 0.22) * scale_factor)


func _add_stone_bridge(position: Vector3, stone: Material) -> void:
	for index in range(9):
		var step := BoxMesh.new()
		step.size = Vector3(4.2, 0.35, 1.0)
		var y := 0.18 + sin(float(index) / 8.0 * PI) * 1.25
		_add_mesh(step, stone, position + Vector3(0, y, 4.0 - index))
	for side in [-1.0, 1.0]:
		_add_column(position + Vector3(side * 1.8, 0.45, 0), 0.12, 1.0, stone)


func _add_island(position: Vector3, stone: Material, vegetation: Material) -> void:
	_add_mesh(SphereMesh.new(), stone, position + Vector3(0, -0.5, 0), Vector3(4.8, 1.3, 3.8))
	_add_mesh(SphereMesh.new(), vegetation, position + Vector3(0, 0.28, 0), Vector3(4.4, 0.28, 3.4))
	for edge in [-1.0, 1.0]:
		_add_mesh(ConeMesh.new(), stone, position + Vector3(edge * 1.6, -2.0, 0), Vector3(0.85, 2.5, 0.85))


func _add_distant_mountain_ridge(material_color: Color) -> void:
	var mountain_material := _make_material(material_color)
	for index in range(7):
		var mountain := ConeMesh.new()
		mountain.radial_segments = 5
		mountain.height = 12.0 + float(index % 3) * 4.0
		mountain.bottom_radius = 8.0
		_add_mesh(mountain, mountain_material, Vector3(-30.0 + index * 10.0, 3.0, -34.0), Vector3(1.2, 1.0, 0.8))
