extends Node2D

var _messages = [
	"SET VAR PLAYER.GUN = GUN.INSTANCE()",
	"INPUT.SHIFT = SHOOT"
]
var _save_data = preload("res://src/resources/save data/goo_level.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	if _save_data.gun_collected:
		$ShootInput.set_params(0.08, 0.8, true, true)
		$ShootInput.write_all(_messages)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
