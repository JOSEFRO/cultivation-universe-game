extends Node3D
class_name ThreeQuarterCameraRig

## Cámara 3/4 con seguimiento amortiguado. Mantiene el encuadre cinematográfico
## sin bloquear el movimiento del personaje.

@export var target_path: NodePath = ^"../Player"
@export var follow_offset := Vector3(5.5, 4.2, 7.0)
@export_range(1.0, 20.0, 0.1) var follow_smoothing: float = 7.0
@export var look_height: float = 1.25

@onready var camera: Camera3D = $Camera3D
var _target: Node3D


func _ready() -> void:
	_target = get_node_or_null(target_path) as Node3D
	camera.current = true


func _process(delta: float) -> void:
	if not is_instance_valid(_target):
		return

	var focus := _target.global_position + Vector3.UP * look_height
	var desired_position := focus + follow_offset
	var weight := 1.0 - exp(-follow_smoothing * delta)
	global_position = global_position.lerp(desired_position, weight)
	camera.look_at(focus, Vector3.UP)
