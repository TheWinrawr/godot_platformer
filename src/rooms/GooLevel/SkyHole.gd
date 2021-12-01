extends Area2D

signal entered

var _save_data = preload("res://src/resources/save data/goo_level.tres")

var player: Player = null
var entered: bool = false

func _ready():
	if _save_data.gun_collected:
		if is_instance_valid(player):
			var events = InputMap.get_action_list("interact")
			InputMap.action_erase_events("interact")
			for e in events:
				InputMap.action_add_event("jump", e)
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact") && !entered:
		entered = true
		$Timer.start(4)
		ScreenShader.noise(4)
		$Noise.play()

func _on_SkyHole_body_entered(body):
	if body is Player:
		player = body
		var events = InputMap.get_action_list("jump")
		InputMap.action_erase_events("jump")
		for e in events:
			InputMap.action_add_event("interact", e)
		$InputLabel.text = "INPUT.UP = ENTER"


func _on_SkyHole_body_exited(body):
	if body is Player:
		player = null
		var events = InputMap.get_action_list("interact")
		InputMap.action_erase_events("interact")
		for e in events:
			InputMap.action_add_event("jump", e)
		$InputLabel.text = "INPUT.UP = JUMP"


func _on_Timer_timeout():
	emit_signal("entered")
	pass # Replace with function body.
