extends Area2D

var _player: Player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Flag_body_entered(body):
	if body is Player:
		body.input_handler.set_input_disabled(true)
		_player = body
		$Timer.start()
		$Win.play()


func _on_Timer_timeout():
	if is_instance_valid(_player):
		_player.velocity.x = 100
	pass # Replace with function body.


func _on_Win_finished():
	$Label.visible = true
	$QuitTimer.start(8)
	pass # Replace with function body.


func _on_QuitTimer_timeout():
	get_tree().quit()
	pass # Replace with function body.
