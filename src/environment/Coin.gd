extends Area2D

signal collected
signal collected_verbose(coin_name)

var _collected: bool = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _collect() -> void:
	_collected = true
	$CollectSFX.play()
	visible = false
	emit_signal("collected")
	emit_signal("collected_verbose", name)

func _on_Coin_body_entered(body):
	if !_collected && body is Player:
		_collect()
