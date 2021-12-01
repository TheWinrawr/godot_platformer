extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_battle() -> void:
	MusicPlayer.play(MusicPlayer.Track.GOO_BOSS, 4)
	pass


func _on_BattleTrigger_body_entered(body):
	MusicPlayer.stop(4)
	$Tween.interpolate_callback(self, 4, "start_battle")
	$Tween.start()
	pass # Replace with function body.
