extends Node3D

const WALK_SPEED := 6.0
const INTERACTION_DISTANCE := 4.8

var player: CharacterBody3D
var camera: Camera3D
var hud_status: Label
var quest_label: Label
var interaction_label: Label
var quest_complete := false
var time_elapsed := 0.0
var shrine_orb: MeshInstance3D

func _ready() -> void:
	_build_environment()
	_build_world()
	_build_player()
	_build_hud()
	_update_hud()

func _process(delta: float) -> void:
	time_elapsed += delta
	if is_instance_valid(shrine_orb):
		shrine_orb.position.y = 3.6 + sin(time_elapsed * 1.4) * 0.22
		shrine_orb.rotate_y(delta * 0.45)
	if is_instance_valid(player) and is_instance_valid(camera):
		camera.global_position = player.global_position + Vector3(0.0, 5.2, 9.0)
		camera.look_at(player.global_position + Vector3(0.0, 1.0, -1.2), Vector3.UP)
		var near_guardian := player.global_position.distance_to(Vector3(0.0, 0.0, -10.0)) <= INTERACTION_DISTANCE
		interaction_label.visible = near_guardian and not quest_complete
		if near_guardian and Input.is_key_pressed(KEY_E) and not quest_complete:
			_complete_first_trial()

func _physics_process(_delta: float) -> void:
	if not is_instance_valid(player):
		return
	var direction := Vector3.ZERO
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		direction.z -= 1.0
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		direction.z += 1.0
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		direction.x -= 1.0
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		direction.x += 1.0
	direction = direction.normalized()
	player.velocity.x = direction.x * WALK_SPEED
	player.velocity.z = direction.z * WALK_SPEED
	if not player.is_on_floor():
		player.velocity.y -= 22.0 * _delta
	else:
		player.velocity.y = 0.0
	if direction.length_squared() > 0.01:
		player.rotation.y = lerp_angle(player.rotation.y, atan2(direction.x, direction.z), 0.18)
	player.move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	if event is InputEventKey and event.pressed and event.keycode == KEY_E:
		if is_instance_valid(player) and player.global_position.distance_to(Vector3(0.0, 0.0, -10.0)) <= INTERACTION_DISTANCE and not quest_complete:
			_complete_first_trial()

func _build_environment() -> void:
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color("#101c31")
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color("#a9c4d6")
	environment.ambient_light_energy = 0.72
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.fog_enabled = true
	environment.fog_light_color = Color("#a7b8c4")
	environment.fog_density = 0.006
	var world_environment := WorldEnvironment.new()
	world_environment.environment = environment
	add_child(world_environment)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-48.0, -28.0, 0.0)
	sun.light_color = Color("#ffe2b1")
	sun.light_energy = 1.15
	sun.shadow_enabled = true
	add_child(sun)

func _build_world() -> void:
	var ground_body := StaticBody3D.new()
	ground_body.name = "ValleyGround"
	var ground_collision := CollisionShape3D.new()
	var ground_shape := BoxShape3D.new()
	ground_shape.size = Vector3(90.0, 1.0, 90.0)
	ground_collision.shape = ground_shape
	ground_collision.position.y = -0.55
	ground_body.add_child(ground_collision)
	add_child(ground_body)
	var ground := MeshInstance3D.new()
	var ground_mesh := PlaneMesh.new()
	ground_mesh.size = Vector2(90.0, 90.0)
	ground.mesh = ground_mesh
	ground.position.y = -0.05
	ground.material_override = _material("#263d3b", 0.0, 0.92)
	add_child(ground)

	var path_material := _material("#7b776a", 0.05, 0.82)
	for i in range(13):
		var stone := MeshInstance3D.new()
		var stone_mesh := BoxMesh.new()
		stone_mesh.size = Vector3(2.1, 0.12, 1.25)
		stone.mesh = stone_mesh
		stone.material_override = path_material
		stone.position = Vector3(sin(float(i) * 0.7) * 0.55, 0.04, 10.0 - float(i) * 1.75)
		stone.rotation.y = sin(float(i)) * 0.08
		add_child(stone)

	for i in range(18):
		var angle := TAU * float(i) / 18.0
		var radius := 28.0 + float(i % 4) * 2.0
		var mountain := MeshInstance3D.new()
		var mountain_mesh := CylinderMesh.new()
		mountain_mesh.top_radius = 0.2
		mountain_mesh.bottom_radius = 5.0 + float(i % 3) * 1.4
		mountain_mesh.height = 11.0 + float(i % 5) * 2.5
		mountain.mesh = mountain_mesh
		mountain.position = Vector3(cos(angle) * radius, mountain_mesh.height * 0.5 - 1.0, sin(angle) * radius - 3.0)
		mountain.material_override = _material("#344c57" if i % 2 == 0 else "#405a60", 0.0, 0.95)
		add_child(mountain)

	for i in range(22):
		var angle := TAU * float(i) / 22.0
		var radius := 10.0 + float(i % 5) * 2.0
		var tree_position := Vector3(cos(angle) * radius, 0.0, sin(angle) * radius - 2.0)
		if abs(tree_position.x) < 3.5 and tree_position.z < 3.0 and tree_position.z > -18.0:
			continue
		_add_tree(tree_position, 0.8 + float(i % 4) * 0.12)

	_build_shrine()
	_add_floating_islands()

func _build_shrine() -> void:
	var stone := _material("#b8a98a", 0.18, 0.55)
	var dark_stone := _material("#394a54", 0.12, 0.75)
	var jade := _material("#65c9b4", 0.25, 0.3, "#1d8d78", 0.75)
	for i in range(5):
		var step := MeshInstance3D.new()
		var mesh := BoxMesh.new()
		mesh.size = Vector3(7.0 - float(i) * 0.5, 0.28, 1.2)
		step.mesh = mesh
		step.position = Vector3(0.0, 0.14 + float(i) * 0.24, -4.0 - float(i) * 1.0)
		step.material_override = stone
		add_child(step)
	for x in [-2.5, 2.5]:
		var pillar := MeshInstance3D.new()
		var pillar_mesh := CylinderMesh.new()
		pillar_mesh.top_radius = 0.3
		pillar_mesh.bottom_radius = 0.42
		pillar_mesh.height = 5.0
		pillar.mesh = pillar_mesh
		pillar.position = Vector3(x, 2.5, -11.0)
		pillar.material_override = stone
		add_child(pillar)
		var cap := MeshInstance3D.new()
		var cap_mesh := BoxMesh.new()
		cap_mesh.size = Vector3(1.15, 0.35, 1.15)
		cap.mesh = cap_mesh
		cap.position = Vector3(x, 5.05, -11.0)
		cap.material_override = dark_stone
		add_child(cap)
	var lintel := MeshInstance3D.new()
	var lintel_mesh := BoxMesh.new()
	lintel_mesh.size = Vector3(6.2, 0.65, 1.4)
	lintel.mesh = lintel_mesh
	lintel.position = Vector3(0.0, 5.45, -11.0)
	lintel.material_override = dark_stone
	add_child(lintel)
	var roof := MeshInstance3D.new()
	var roof_mesh := PrismMesh.new()
	roof_mesh.size = Vector3(7.5, 1.2, 2.6)
	roof.mesh = roof_mesh
	roof.position = Vector3(0.0, 6.25, -11.0)
	roof.material_override = stone
	add_child(roof)
	shrine_orb = MeshInstance3D.new()
	var orb_mesh := SphereMesh.new()
	orb_mesh.radius = 0.68
	orb_mesh.height = 1.36
	shrine_orb.mesh = orb_mesh
	shrine_orb.position = Vector3(0.0, 3.6, -10.0)
	shrine_orb.material_override = jade
	add_child(shrine_orb)
	var glow := OmniLight3D.new()
	glow.position = Vector3(0.0, 3.5, -10.0)
	glow.light_color = Color("#68e4c7")
	glow.light_energy = 2.4
	glow.omni_range = 12.0
	add_child(glow)
	_add_guardian()

func _add_guardian() -> void:
	var guardian := Node3D.new()
	guardian.name = "FirstGuardian"
	guardian.position = Vector3(0.0, 0.0, -10.0)
	var body := MeshInstance3D.new()
	var body_mesh := CapsuleMesh.new()
	body_mesh.radius = 0.58
	body_mesh.height = 2.0
	body.mesh = body_mesh
	body.position.y = 1.05
	body.material_override = _material("#56636b", 0.25, 0.7)
	guardian.add_child(body)
	var head := MeshInstance3D.new()
	var head_mesh := SphereMesh.new()
	head_mesh.radius = 0.48
	head_mesh.height = 0.96
	head.mesh = head_mesh
	head.position.y = 2.25
	head.material_override = _material("#7e8c8b", 0.15, 0.6)
	guardian.add_child(head)
	var eyes := MeshInstance3D.new()
	var eyes_mesh := SphereMesh.new()
	eyes_mesh.radius = 0.13
	eyes_mesh.height = 0.26
	eyes.mesh = eyes_mesh
	eyes.position = Vector3(0.0, 2.28, -0.43)
	eyes.material_override = _material("#b8f7df", 0.1, 0.2, "#54dcb8", 1.8)
	guardian.add_child(eyes)
	add_child(guardian)

func _add_tree(at: Vector3, scale_factor: float) -> void:
	var trunk := MeshInstance3D.new()
	var trunk_mesh := CylinderMesh.new()
	trunk_mesh.top_radius = 0.16 * scale_factor
	trunk_mesh.bottom_radius = 0.28 * scale_factor
	trunk_mesh.height = 3.2 * scale_factor
	trunk.mesh = trunk_mesh
	trunk.position = at + Vector3(0.0, 1.6 * scale_factor, 0.0)
	trunk.material_override = _material("#574a3d", 0.0, 0.95)
	add_child(trunk)
	for i in range(3):
		var crown := MeshInstance3D.new()
		var crown_mesh := SphereMesh.new()
		crown_mesh.radius = (1.0 - float(i) * 0.12) * scale_factor
		crown_mesh.height = 1.8 * scale_factor
		crown.mesh = crown_mesh
		crown.position = at + Vector3(0.0, (3.1 + float(i) * 0.42) * scale_factor, 0.0)
		crown.material_override = _material("#47796a" if i % 2 == 0 else "#648d73", 0.0, 0.9)
		add_child(crown)

func _add_floating_islands() -> void:
	for i in range(7):
		var island := MeshInstance3D.new()
		var mesh := SphereMesh.new()
		mesh.radius = 1.7 + float(i % 3) * 0.45
		mesh.height = mesh.radius * 0.75
		island.mesh = mesh
		var angle := TAU * float(i) / 7.0
		island.position = Vector3(cos(angle) * 19.0, 8.0 + float(i % 3) * 2.0, sin(angle) * 19.0 - 7.0)
		island.material_override = _material("#526d76", 0.08, 0.9)
		add_child(island)
		var crystal := MeshInstance3D.new()
		var crystal_mesh := PrismMesh.new()
		crystal_mesh.size = Vector3(0.45, 1.1, 0.45)
		crystal.mesh = crystal_mesh
		crystal.position = island.position + Vector3(0.0, 1.2, 0.0)
		crystal.material_override = _material("#78d8cb", 0.25, 0.25, "#277e80", 0.7)
		add_child(crystal)

func _build_player() -> void:
	player = CharacterBody3D.new()
	player.name = "Cultivator"
	player.position = Vector3(0.0, 0.2, 13.0)
	var collision := CollisionShape3D.new()
	var shape := CapsuleShape3D.new()
	shape.radius = 0.42
	shape.height = 1.8
	collision.shape = shape
	collision.position.y = 0.9
	player.add_child(collision)
	var robe := MeshInstance3D.new()
	var robe_mesh := CapsuleMesh.new()
	robe_mesh.radius = 0.48
	robe_mesh.height = 1.65
	robe.mesh = robe_mesh
	robe.position.y = 0.95
	robe.material_override = _material("#263f59", 0.1, 0.65)
	player.add_child(robe)
	var sash := MeshInstance3D.new()
	var sash_mesh := BoxMesh.new()
	sash_mesh.size = Vector3(0.9, 0.18, 0.56)
	sash.mesh = sash_mesh
	sash.position.y = 1.1
	sash.material_override = _material("#d0ad70", 0.2, 0.4)
	player.add_child(sash)
	var head := MeshInstance3D.new()
	var head_mesh := SphereMesh.new()
	head_mesh.radius = 0.34
	head_mesh.height = 0.68
	head.mesh = head_mesh
	head.position.y = 1.95
	head.material_override = _material("#d8bda3", 0.0, 0.8)
	player.add_child(head)
	var hair := MeshInstance3D.new()
	var hair_mesh := SphereMesh.new()
	hair_mesh.radius = 0.36
	hair_mesh.height = 0.42
	hair.mesh = hair_mesh
	hair.position = Vector3(0.0, 2.17, 0.02)
	hair.material_override = _material("#171b25", 0.0, 0.8)
	player.add_child(hair)
	add_child(player)
	camera = Camera3D.new()
	camera.name = "FollowCamera"
	camera.current = true
	camera.fov = 52.0
	add_child(camera)

func _build_hud() -> void:
	var layer := CanvasLayer.new()
	layer.name = "GameHUD"
	add_child(layer)
	var panel := PanelContainer.new()
	panel.position = Vector2(24.0, 20.0)
	panel.custom_minimum_size = Vector2(330.0, 122.0)
	panel.add_theme_stylebox_override("panel", _panel_style())
	layer.add_child(panel)
	var stack := VBoxContainer.new()
	stack.add_theme_constant_override("separation", 7)
	panel.add_child(stack)
	var title := Label.new()
	title.text = "SIETE RAÍCES   /   PRÓLOGO"
	title.add_theme_font_size_override("font_size", 12)
	title.add_theme_color_override("font_color", Color("#e6c58c"))
	stack.add_child(title)
	hud_status = Label.new()
	hud_status.add_theme_font_size_override("font_size", 17)
	hud_status.add_theme_color_override("font_color", Color("#f3eee4"))
	stack.add_child(hud_status)
	quest_label = Label.new()
	quest_label.add_theme_font_size_override("font_size", 11)
	quest_label.add_theme_color_override("font_color", Color("#b4c8ce"))
	quest_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	stack.add_child(quest_label)
	interaction_label = Label.new()
	interaction_label.text = "PULSA E PARA ESCUCHAR AL GUARDIÁN"
	interaction_label.anchor_left = 0.5
	interaction_label.anchor_right = 0.5
	interaction_label.anchor_top = 0.83
	interaction_label.anchor_bottom = 0.9
	interaction_label.offset_left = -190.0
	interaction_label.offset_right = 190.0
	interaction_label.add_theme_font_size_override("font_size", 13)
	interaction_label.add_theme_color_override("font_color", Color("#d9f3df"))
	interaction_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	layer.add_child(interaction_label)
	var controls := Label.new()
	controls.text = "WASD / FLECHAS · MOVER     E · INTERACTUAR     ESC · MENÚ"
	controls.anchor_left = 0.0
	controls.anchor_right = 1.0
	controls.anchor_top = 1.0
	controls.anchor_bottom = 1.0
	controls.offset_left = 24.0
	controls.offset_right = -24.0
	controls.offset_top = -34.0
	controls.offset_bottom = -12.0
	controls.add_theme_font_size_override("font_size", 10)
	controls.add_theme_color_override("font_color", Color("#c5d0d1"))
	controls.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	layer.add_child(controls)

func _update_hud() -> void:
	if is_instance_valid(hud_status):
		hud_status.text = "El Valle del Primer Alba"
	if is_instance_valid(quest_label):
		quest_label.text = "MISIÓN PRINCIPAL\n" + ("✓ El guardián reconoció tu presencia" if quest_complete else "Encuentra al Guardián del Primer Umbral")

func _complete_first_trial() -> void:
	if quest_complete:
		return
	quest_complete = true
	_update_hud()
	interaction_label.visible = false
	var toast := Label.new()
	toast.text = "EL PRIMER UMBRAL HA DESPERTADO"
	toast.position = Vector2(0.0, 150.0)
	toast.anchor_left = 0.5
	toast.anchor_right = 0.5
	toast.offset_left = -220.0
	toast.offset_right = 220.0
	toast.add_theme_font_size_override("font_size", 18)
	toast.add_theme_color_override("font_color", Color("#e8d09c"))
	toast.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	get_node("GameHUD").add_child(toast)
	var tween := create_tween()
	tween.tween_property(toast, "modulate:a", 0.0, 4.0).set_delay(1.5)
	tween.tween_callback(toast.queue_free)

func _material(color_hex: String, metallic: float, roughness: float, glow_color: String = "#000000", glow_energy: float = 0.0) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(color_hex)
	material.metallic = metallic
	material.roughness = roughness
	if glow_energy > 0.0:
		material.emission_enabled = true
		material.emission = Color(glow_color)
		material.emission_energy_multiplier = glow_energy
	return material

func _panel_style() -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.025, 0.055, 0.075, 0.88)
	style.border_color = Color("#c5a66d", 0.6)
	style.set_border_width_all(1)
	style.set_corner_radius_all(8)
	style.content_margin_left = 16.0
	style.content_margin_right = 16.0
	style.content_margin_top = 12.0
	style.content_margin_bottom = 12.0
	return style
