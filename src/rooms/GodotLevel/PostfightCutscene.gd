extends Node2D

signal exited

var step: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$ScrollingText/Label.align = Label.ALIGN_CENTER
	$ScrollingText/Label.grow_horizontal = Label.GROW_DIRECTION_BOTH
	$WhiteScreen.modulate.a = 0
	pass # Replace with function body.

func _on_GodotBoss_killed():
	var delay: float = 1
	var messages: Array = [
		"NO",
		"HOW DID YOU DEFEAT ME"
	]
	step = 0
	
	$ScrollingText.set_params(0.1, 3)
	$Tween.interpolate_callback($ScrollingText, delay, "write_all", messages)
	$Tween.start()

func _on_Timer_timeout():
	emit_signal("exited")
	pass # Replace with function body.


func _on_ScrollingText_queue_emptied():
	step += 1
	match step:
		1:
			var message = "THIS CAN'T BE HAPPENING"
			$ScrollingText.set_params(0.18, 3)
			$Tween.interpolate_callback($ScrollingText, 3, "write", message)
			$Tween.interpolate_callback($RisingNoise, 3, "play")
			$Tween.interpolate_property($WhiteScreen, "modulate:a", 0, 1, 4, Tween.TRANS_LINEAR, Tween.EASE_IN, 3)
			$Tween.start()
			$Timer.start(12)
