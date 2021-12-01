extends Room

var _gun_pfb = preload("res://src/characters/player/gun/Gun.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicPlayer.play(MusicPlayer.Track.DARK_AMBIENCE, 3)
	var gun = _gun_pfb.instance()
	$Player.add_child(gun)
	
	$PrefightCutscene.boss = $GodotBoss
	#$GodotBoss.modulate.a = 0


func _on_PrefightCutscene_started():
	$BossroomCeiling.global_position = Vector2.ZERO
	pass # Replace with function body.


func _on_GodotBoss_gravity_flipped(dir):
	ScreenShader.glitch(0.5)
	player.up_dir = dir
	$GlitchSFX.play()


func _on_PostfightCutscene_exited():
	exit("EndRoom")
	pass # Replace with function body.
