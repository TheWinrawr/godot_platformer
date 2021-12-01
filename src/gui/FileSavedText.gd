extends Node2D

export(String) var save_text
export(String) var reload_text

var _camera_moved: bool = false
var _write_reload: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("game_saved", self, "write_save_text")
	EventBus.connect("room_reloaded", self, "_on_room_reloaded")
	EventBus.connect("camera_moved", self, "erase")
	
	$ScrollingText.set_params(0.05, 0.5, false, true)
	pass # Replace with function body.

func write_save_text() -> void:
	if _write_reload:
		write_reload_text()
		return
	if _camera_moved:
		$ScrollingText.write(save_text)
		_camera_moved = false
		
func write_reload_text() -> void:
	$ScrollingText.write(reload_text)
	_camera_moved = false
	_write_reload = false
	
func _on_room_reloaded() -> void:
	_write_reload = true
	
func erase() -> void:
	if _write_reload:
		write_reload_text()
		return
	$ScrollingText.clear()
	_camera_moved = true
