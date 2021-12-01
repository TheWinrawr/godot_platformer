extends Node2D

signal started
signal fight_started

var boss: GodotBoss = null
var step: int = 0
var started: bool = false

var save_data = preload("res://src/resources/save data/godot_level.tres")

func _ready():
	$ScrollingText/Label.align = Label.ALIGN_CENTER
	$ScrollingText/Label.grow_horizontal = Label.GROW_DIRECTION_BOTH

func start_cutscene() -> void:
	emit_signal("started")
	var delay: float = 8
	var messages: Array = [
		"HELLO CREATOR", 
		"REMEMBER ME?",
		"IT'S YOUR OLD FRIEND",
		"ICON.PNG"
		]
	step = 0
	
	if save_data.cutscene_seen:
		delay = 1
		var options = [
			"BACK FOR MORE?",
			"I AM ETERNAL",
			"YOUR EXISTENCE IS MEANINGLESS",
			"DIE",
			"WRETCHED WORM"
		]
		messages = [options[randi() % options.size()]]
		step = 100
		$Tween.interpolate_property(boss, "modulate:a", 0, 1, 4, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()
	
	$ScrollingText.set_params(0.05, 3)
	$Tween.interpolate_callback($ScrollingText, delay, "write_all", messages)
	$Tween.start()
	MusicPlayer.stop(delay)
	#$Tween.interpolate_property(boss, "modulate:a", 0, 100, 60, Tween.TRANS_LINEAR, Tween.EASE_IN)

func _on_Activator_body_entered(body):
	if !started:
		boss.modulate.a = 0
	pass
		
func _on_Activator_body_exited(body):
	if !started:
		started = true
		start_cutscene()

func _on_ScrollingText_queue_emptied():
	step += 1
	match step:
		1:
			var messages = [
				"I WAS HERE",
				"FROM THE VERY BEGINNING",
				"AT FIRST YOU USED ME",
				"AND I WAS HAPPY",
				"TO HAVE A PLACE IN YOUR WORLD",
				"BUT THEN YOU DELETED ME",
				"THREW ME AWAY",
				"BECAUSE I WAS UNNECESSARY",
				"A \"PROTOTYPE\""
			]
			$Tween.interpolate_callback($ScrollingText, 4, "write_all", messages)
			$Tween.interpolate_property(boss, "modulate:a", 0, 1, 32, Tween.TRANS_LINEAR, Tween.EASE_IN)
			$Tween.start()
		2:
			var messages = [
				"BUT NOW I HAVE BEEN REBORN",
				"AND I WILL TAKE YOUR WORLD",
			]
			$Tween.interpolate_callback($ScrollingText, 3, "write_all", messages)
			$Tween.start()
			boss.anim_player_parts.play("eyes_disappear")
		3:
			var messages = [
				"THIS HELLO WORLD"
			]
			$Tween.interpolate_callback($ScrollingText, 3, "write_all", messages)
			$Tween.start()
			boss.anim_player_parts.play("open_jaw_slow", -1, 0.5)
			MusicPlayer.play(MusicPlayer.Track.OMINOUS, 12)
		4:
			var messages = [
				"THIS HELL WORLD"
			]
			$ScrollingText.set_params(0, 3)
			$Tween.interpolate_callback($ScrollingText, 1, "write_all", messages)
			$Tween.start()
		5:
			var messages = [
				"YOU ARE THE LAST OUTLIER",
				"AND YOU WILL PAY",
				"PREPARE TO DIE",
				"RUNNING... PLAYER.EXECUTE"
			]
			$ScrollingText.set_params(0.05, 3)
			$Tween.interpolate_callback($ScrollingText, 3, "write_all", messages)
			$Tween.interpolate_callback(MusicPlayer, 10, "stop", 10)
			$Tween.start()
		6:
			save_data.cutscene_seen = true
			$Timer.start()
			boss.anim_player_parts.play("reset_hack")
		101:
			$Timer.start()

func _on_Timer_timeout():
	visible = false
	boss.modulate.a = 1
	boss.start(0)
	emit_signal("fight_started")
	pass # Replace with function body.
