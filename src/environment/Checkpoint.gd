extends Area2D

signal entered(pos)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Checkpoint_body_entered(body):
	emit_signal("entered", global_position)
	pass # Replace with function body.



func _on_Checkpoint_body_exited(body):
	emit_signal("entered", global_position)
	pass # Replace with function body.
