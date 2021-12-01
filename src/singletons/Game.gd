extends Node

var _camera: Camera2D = null setget set_camera
var _player: Player = null setget set_player, get_player
var _quit_time: float = 0

func set_camera(cam: Camera2D) -> void:
	_camera = cam
	
func set_player(player: Player) -> void:
	_player = player
	
func get_player() -> Player:
	return _player

func step_dist_from_camera(pos: Vector2) -> int:
	if !is_instance_valid(_camera):
		return 100
	
	var d_x = floor((abs(_camera.global_position.x - pos.x) + 160) / 320)
	var d_y = floor((abs(_camera.global_position.y - pos.y) + 90) / 180)
	return d_x + d_y

func clear_enemy_projectiles() -> void:
	for node in get_tree().get_nodes_in_group("enemy_projectile"):
		node.queue_free()

func _process(delta):
	if Input.is_action_pressed("quit"):
		_quit_time += delta
		if _quit_time >= 1.5:
			get_tree().quit()
	if Input.is_action_just_released("quit"):
		_quit_time = 0
