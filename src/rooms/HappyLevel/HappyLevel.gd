extends Room

var music_pos: float = 0
var started: bool = false

func _ready():
	$Player/PlayerFSM/Jump/HappyJumpSFX.volume_db = 0
	$Player/PlayerFSM/Jump/NotHappyJumpSFX.volume_db = -80
	$Player.freeze()

func _on_GlitchArea_entered():
	$MusicGlitchTimer.start()
	music_pos = $Music.get_playback_position()
	player.freeze()


func _on_GlitchArea_exit_to_error_screen():
	exit("ErrorScreen")
	pass # Replace with function body.


func _on_MusicGlitchTimer_timeout():
	$Music.seek(music_pos)
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed && !started:
			started = true
			$Player.unfreeze()
			$Music.play()
			$WelcomeScreen.visible = false
