extends Node2D

var max_health_number: float = 87539319

func _ready():
	_update_text(1, 1)

func _update_text(health: float, max_health: float) -> void:
	var num = floor(max_health_number * (health / max_health))
	if num < 0:
		num = 0
	for label in get_children():
		label.text = "0x%08d" % num

func _on_GooBoss_damaged(health, max_health):
	_update_text(health, max_health)
