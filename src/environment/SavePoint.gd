extends Area2D

signal entered(pos)
signal saved

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_SavePoint_body_entered(body):
	emit_signal("entered", global_position)
	emit_signal("saved")
	EventBus.emit_signal("game_saved")


func _on_SavePoint_body_exited(body):
	emit_signal("entered", global_position)
	emit_signal("saved")
	EventBus.emit_signal("game_saved")
