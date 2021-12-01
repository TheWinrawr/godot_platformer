extends Node2D

class_name Room

signal exited(from_room, to_room)
signal reloaded(room_name)

export(String) var room_name

onready var player: Player = $Player
onready var spawn_pos: Vector2 = player.global_position

var _save_data: RoomSaveData = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera.target = $Player
	
	player.connect("respawned", self, "_on_player_respawned")
	player.connect("died", self, "_on_player_died")
	for checkpoint in $Checkpoints.get_children():
		if checkpoint.has_signal("entered"):
			checkpoint.connect("entered", self, "_on_checkpoint_entered")
	for save_point in $SavePoints.get_children():
		if save_point.has_signal("entered"):
			save_point.connect("entered", self, "_on_save_point_entered")
			
	for node in get_tree().get_nodes_in_group("exit"):
		node.connect("exited", self, "exit")
		
func enter(prev_room: String, save_data: RoomSaveData) -> void:
	_save_data = save_data
	for node in get_tree().get_nodes_in_group("persist"):
		if node.has_method("reload"):
			node.reload()
		if node.has_method("reload_with_data"):
			node.reload_with_data(save_data)
	if is_instance_valid(save_data) && save_data.save_point_triggered:
		player.global_position = save_data.spawn_pos
	EventBus.emit_signal("room_reloaded")

func exit(to_room: String) -> void:
	emit_signal("exited", room_name, to_room)

func reload() -> void:
	emit_signal("reloaded", room_name)

func _on_checkpoint_entered(checkpoint_pos: Vector2) -> void:
	spawn_pos = checkpoint_pos
	
func _on_save_point_entered(save_point_pos: Vector2) -> void:
	spawn_pos = save_point_pos
	if _save_data:
		_save_data.save_point_triggered = true
		_save_data.spawn_pos = save_point_pos
	
func _on_player_respawned() -> void:
	player.global_position = spawn_pos

func _on_player_died() -> void:
	reload()
