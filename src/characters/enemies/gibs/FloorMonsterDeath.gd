extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Particles2D.emitting = true
	$Tween.interpolate_property($Sprite, "modulate:a", 1, 0, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
