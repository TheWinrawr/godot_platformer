extends Node2D

var max_health_number: float = 87539319

func _ready():
	_update_text(1, 1)
	visible = false

func _on_GodotBoss_damaged(health, max_health):
	_update_text(health, max_health)

func _update_text(health: int, max_health: int) -> void:
	var p = (health + 0.0) / max_health
	var num = floor(max_health_number * p)
	if num < 0:
		num = 0
	for label in get_children():
		label.text = "0x%08d" % num


func _on_PrefightCutscene_fight_started():
	visible = true
	pass # Replace with function body.
