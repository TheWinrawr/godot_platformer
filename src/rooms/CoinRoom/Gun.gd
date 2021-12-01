extends Area2D

signal collected

var _collected: bool = false

func _on_Gun_body_entered(body):
	if body is Player && !_collected:
		_collected = true
		visible = false
		ScreenShader.noise(4)
		$Timer.start(4)
		$Noise.play()


func _on_Timer_timeout():
	emit_signal("collected")
	pass # Replace with function body.
