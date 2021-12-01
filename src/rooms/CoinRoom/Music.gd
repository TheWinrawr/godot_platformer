extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_First_body_entered(body):
	if pitch_scale > 0.9:
		$Tween.interpolate_property(self, "pitch_scale", pitch_scale, 0.8, 5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()
	pass # Replace with function body.


func _on_Second_body_entered(body):
	if pitch_scale > 0.75:
		$Tween.interpolate_property(self, "pitch_scale", pitch_scale, 0.6, 10, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()


func _on_Gun_body_entered(body):
	$Tween.interpolate_property(self, "volume_db", volume_db, -80, 4, Tween.TRANS_QUART, Tween.EASE_IN)
	$Tween.start()
	pass # Replace with function body.
