extends Room

var _gun_pfb = preload("res://src/characters/player/gun/Gun.tscn")
var _coins_collected: PoolStringArray = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for coin in $Coins.get_children():
		coin.connect("collected_verbose", self, "_on_coin_collected")
	MusicPlayer.play(MusicPlayer.Track.DARK_AMBIENCE, 3)
		
#	var gun = _gun_pfb.instance()
#	$Player.add_child(gun)
	
func enter(prev_room: String, save_data: RoomSaveData) -> void:
	.enter(prev_room, save_data)
	_coins_collected = save_data.coins_collected
	for coin_name in _coins_collected:
		var coin = $Coins.get_node(coin_name)
		coin.queue_free()
	
	if save_data.gun_collected:
		var gun = _gun_pfb.instance()
		$Player.add_child(gun)
	
	$CoinCounter.update_counter(_coins_collected.size(), 4)
	if _coins_collected.size() >= 4:
		$TopLevelBlockade.queue_free()

func _on_coin_collected(coin_name: String) -> void:
	_coins_collected.append(coin_name)
	$CoinCounter.update_counter(_coins_collected.size(), 4)
	if _coins_collected.size() >= 4:
		$TopLevelBlockade.queue_free()
		ScreenShader.noise_instant(0.4, 0.6)
		$QuickNoise.play()
	player.heal(10)

func _on_save_point_entered(save_point_pos: Vector2) -> void:
	._on_save_point_entered(save_point_pos)
	_save_data.coins_collected = _coins_collected
	_save_data.monsters_killed = $MonsterTargets.monsters_killed


func _on_SkyHole_entered():
	exit("CoinRoom")
	pass # Replace with function body.
