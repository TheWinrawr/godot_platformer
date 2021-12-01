extends Room

var _num_coins_collected: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for coin in $Coins.get_children():
		coin.connect("collected", self, "_on_coin_collected")
	$GravitySwitch.connect("flipped", self, "_on_gravity_switch_flipped")
	MusicPlayer.play(MusicPlayer.Track.DARK_AMBIENCE, 3)
	pass # Replace with function body.
	
func enter(prev_room: String, save_data: RoomSaveData) -> void:
	.enter(prev_room, save_data)
	if save_data.top_coin_collected:
		_num_coins_collected += 1
	if save_data.tree_coin_collected:
		_num_coins_collected += 1
	if save_data.gravity_coin_collected:
		_num_coins_collected += 1
	if save_data.exit_coin_collected:
		_num_coins_collected += 1
		
	$CoinCounterText.update_counter(_num_coins_collected, 4)
	if _num_coins_collected >= 4:
		$NoiseTiles.queue_free()

func _on_coin_collected() -> void:
	_num_coins_collected += 1
	$CoinCounterText.update_counter(_num_coins_collected, 4)
	$Player.heal(10)
	
	if _num_coins_collected >= 4:
		$NoiseTiles.queue_free()
		ScreenShader.noise_instant(0.4, 0.6)
		$QuickNoise.play()

func _on_gravity_switch_flipped(up_dir: Vector2) -> void:
	player.up_dir = up_dir
