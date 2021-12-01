extends Label

func _process(delta: float) -> void:
	var input = "NULL"
	if Input.is_action_pressed("jump"):
		input = "JUMP"
	elif Input.is_action_pressed("left"):
		input = "LEFT"
	elif Input.is_action_pressed("right"):
		input = "RIGHT"
	
	text = "Player.INPUT = %s" % input
