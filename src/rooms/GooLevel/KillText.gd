extends Label

var data = preload("res://src/resources/save data/goo_level.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	if data.gun_collected:
		text = "MURDERER"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
