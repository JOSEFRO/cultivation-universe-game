extends CharacterBody3D
class_name HumanoidController

## Controlador base para personajes humanoides cinematográficos.
## El modelo y su AnimationTree se conectan mediante NodePaths exportados.

@export_group("Movimiento")
@export var walk_speed: float = 2.4
@export var run_speed: float = 5.2
@export var acceleration: float = 11.0
@export var deceleration: float = 15.0
@export var turn_speed: float = 9.0
@export var jump_velocity: float = 4.5

@export_group("Animación")
@export_node_path("AnimationTree") var animation_tree_path: NodePath = ^"AnimationTree"
@export var locomotion_blend_parameter: String = "parameters/Locomotion/blend_position"
@export var state_machine_parameter: String = "parameters/StateMachine/playback"

@export_group("Cámara")
@export var camera_path: NodePath = ^"../CameraRig/Camera3D"

var _animation_tree: AnimationTree
var _state_machine: AnimationNodeStateMachinePlayback
var _gravity: float = float(ProjectSettings.get_setting("physics/3d/default_gravity"))
var _camera: Camera3D


func _ready() -> void:
	_animation_tree = get_node_or_null(animation_tree_path) as AnimationTree
	_camera = get_node_or_null(camera_path) as Camera3D
	if _animation_tree:
		_animation_tree.active = true
		_state_machine = _animation_tree.get(state_machine_parameter) as AnimationNodeStateMachinePlayback
	_ensure_input_actions()


func _physics_process(delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var move_direction := _get_camera_relative_direction(input_vector)
	var is_running := Input.is_action_pressed("run")
	var target_speed := run_speed if is_running else walk_speed

	if move_direction.length_squared() > 0.001:
		var target_velocity := move_direction * target_speed
		velocity.x = move_toward(velocity.x, target_velocity.x, acceleration * delta)
		velocity.z = move_toward(velocity.z, target_velocity.z, acceleration * delta)
		_face_direction(move_direction, delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, deceleration * delta)
		velocity.z = move_toward(velocity.z, 0.0, deceleration * delta)

	if not is_on_floor():
		velocity.y -= _gravity * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity

	move_and_slide()
	_update_animation(move_direction, is_running)


func _get_camera_relative_direction(input_vector: Vector2) -> Vector3:
	if input_vector.length_squared() < 0.001:
		return Vector3.ZERO

	var forward := Vector3.FORWARD
	var right := Vector3.RIGHT
	if is_instance_valid(_camera):
		forward = -_camera.global_basis.z
		right = _camera.global_basis.x

	forward.y = 0.0
	right.y = 0.0
	forward = forward.normalized()
	right = right.normalized()
	return (right * input_vector.x + forward * -input_vector.y).normalized()


func _face_direction(direction: Vector3, delta: float) -> void:
	var target_yaw := atan2(-direction.x, -direction.z)
	rotation.y = lerp_angle(rotation.y, target_yaw, 1.0 - exp(-turn_speed * delta))


func _update_animation(move_direction: Vector3, is_running: bool) -> void:
	if not _animation_tree:
		return

	var horizontal_speed := Vector2(velocity.x, velocity.z).length()
	var normalized_speed := clampf(horizontal_speed / maxf(run_speed, 0.01), 0.0, 1.0)
	if _animation_tree.get(locomotion_blend_parameter) != null:
		_animation_tree.set(locomotion_blend_parameter, normalized_speed)

	if _state_machine:
		if not is_on_floor():
			_state_machine.travel("Air")
		elif horizontal_speed > 0.15:
			_state_machine.travel("Locomotion")
		else:
			_state_machine.travel("Idle")


func _ensure_input_actions() -> void:
	_add_key_action("move_forward", KEY_W)
	_add_key_action("move_back", KEY_S)
	_add_key_action("move_left", KEY_A)
	_add_key_action("move_right", KEY_D)
	_add_key_action("run", KEY_SHIFT)
	_add_key_action("jump", KEY_SPACE)


func _add_key_action(action_name: StringName, keycode: Key) -> void:
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name)
	var event := InputEventKey.new()
	event.physical_keycode = keycode
	if not InputMap.action_has_event(action_name, event):
		InputMap.action_add_event(action_name, event)
