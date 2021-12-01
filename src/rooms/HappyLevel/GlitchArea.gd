extends Area2D

signal entered
signal exit_to_error_screen

func _on_GlitchArea_body_entered(body):
	if body is Player:
		emit_signal("entered")
		$GlitchTimer.start()
		ScreenShader.glitch($GlitchTimer.wait_time, 0.04, 0.2, 40, 0.04, 1.4)
		

func _on_GlitchTimer_timeout():
	emit_signal("exit_to_error_screen")
