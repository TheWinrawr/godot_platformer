extends Room

var _goo_level_save_data = preload("res://src/resources/save data/goo_level.tres")

var _num_coins_collected: int = 0
var _num_coins: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for coin in $Coins.get_children():
		coin.connect("collected", self, "_on_coin_collected")
		_num_coins += 1
	$GUI/CoinCounterText.update_text(_num_coins_collected, _num_coins)
	MusicPlayer.stop()
	
	$Player/PlayerFSM/Jump/HappyJumpSFX.volume_db = 0
	$Player/PlayerFSM/Jump/NotHappyJumpSFX.volume_db = -80
	#$NoiseTiles.queue_free()

func _on_coin_collected():
	_num_coins_collected += 1
	$GUI/CoinCounterText.update_text(_num_coins_collected, _num_coins)
	if _num_coins_collected >= _num_coins:
		$NoiseTiles.queue_free()

func _on_Gun_collected():
	_goo_level_save_data.gun_collected = true
	exit("GooLevel")
	pass # Replace with function body.
