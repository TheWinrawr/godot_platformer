extends Area2D

signal exited(to_room)

export(String) var to_room

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Exit_body_entered(body):
	if body is Player:
		emit_signal("exited", to_room)
	pass # Replace with function body.
