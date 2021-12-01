extends "res://src/environment/TileMap.gd"

var save_data: RoomSaveData = preload("res://src/resources/save data/dark_level_enter.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_TreeCoin_collected():
	ScreenShader.glitch(0.5)
	$Timer.start()


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.

func reload() -> void:
	if save_data.tree_coin_collected:
		queue_free()
