extends Node2D

func update_counter(num_coins: int, num_total_coins: int) -> void:
	for label in get_children():
		if label is Label:
			label.text = "%d/%d" % [num_coins, num_total_coins]
