extends "res://src/environment/TileMap.gd"

func reload_with_data(save_data: RoomSaveData) -> void:
	if !save_data.gun_collected:
		queue_free()
