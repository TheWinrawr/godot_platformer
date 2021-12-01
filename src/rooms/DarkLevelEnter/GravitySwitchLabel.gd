extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().connect("flipped", self ,"_on_gravity_switch_flipped")
	pass # Replace with function body.

func _on_gravity_switch_flipped(up_dir: Vector2) -> void:
	text = "%d" % (up_dir.y * -1)
	pass
