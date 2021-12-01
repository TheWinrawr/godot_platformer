extends "res://src/environment/Coin.gd"

var save_data: RoomSaveData = preload("res://src/resources/save data/dark_level_enter.tres")

func _ready() -> void:
	for save_point in get_tree().get_nodes_in_group("save_point"):
		save_point.connect("saved", self, "_on_save")

func reload() -> void:
	if save_data.gravity_coin_collected:
		queue_free()

func _on_save() -> void:
	save_data.gravity_coin_collected = _collected
