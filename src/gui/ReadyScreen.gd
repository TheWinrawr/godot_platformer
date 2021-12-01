extends Control

onready var label: Label = $Label

func display(level_name: String) -> void:
	var list = ["READY!"]
	if level_name == "DarkLevelEnter":
		list = ["READY!", "READY!", "READY!", "HELLO WORLD"]
	elif level_name == "GooLevel":
		list = ["READY!", "READY!", "HELLO WORLD", "HELLO WORLD", "I SEE YOU", "GET OUT", "STOP", "I SEE YOU"]
	elif level_name == "GodotLevel":
		list = ["HELLO WORLD", "GOODBYE", "GIVE UP", "READY!", ""]
		$Timer.start()
	label.text = list[randi() % list.size()]

func _on_Timer_timeout():
	match label.text:
		"HELLO WORLD":
			label.text = "HELL WORLD"
		"READY!":
			label.text += "\nTO DIE"
	pass # Replace with function body.
