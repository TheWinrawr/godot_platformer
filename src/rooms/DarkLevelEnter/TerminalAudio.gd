extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("camera_moved", self, "_on_camera_moved")
	pass # Replace with function body.

func _on_camera_moved() -> void:
	var d = Game.step_dist_from_camera(get_parent().global_position)
	if d == 0:
		play()
		volume_db = 0
	elif d == 1:
		play()
		volume_db = -15
	else:
		stop()
