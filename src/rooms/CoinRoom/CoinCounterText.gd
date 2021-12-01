extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_text(num_coins_collected: int, num_coins: int) -> void:
	text = "%d/%d" % [num_coins_collected, num_coins]
