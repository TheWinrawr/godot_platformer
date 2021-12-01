extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TreeMusicTrigger_body_entered(body):
	MusicPlayer.play(MusicPlayer.Track.TREE_ROOM, 4)
	pass # Replace with function body.


func _on_TreeMusicTrigger_body_exited(body):
	MusicPlayer.play(MusicPlayer.Track.DARK_AMBIENCE, 6)
	pass # Replace with function body.


func _on_TreeCoin_collected():
	$Glitch.play()
	MusicPlayer.play(MusicPlayer.Track.DARK_AMBIENCE, 0)
	$CollisionShape2D.set_deferred("disabled", true)
	pass # Replace with function body.

func reload_with_data(save_data: RoomSaveData) -> void:
	if save_data.tree_coin_collected:
		queue_free()
