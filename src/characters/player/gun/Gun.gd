extends Node2D

onready var _word_list = $CodeText.word_list

var _bullet_pfb = preload("res://src/characters/player/gun/PlayerBullet.tscn")
var _can_shoot: bool = true
var _input_disabled: bool = false
var _dir_x: int = 1

var _word_list_index: int = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("set_player_input_disabled", self, "_on_set_player_input_disabled")

func _process(delta):
	var dir = 0
	if Input.is_action_pressed("left"):
		dir -= 1
	if Input.is_action_pressed("right"):
		dir += 1
	if dir != 0:
		_dir_x = dir
		
	if Input.is_action_just_pressed("shoot"):
		pass
		#_word_list_index = randi() % _word_list.size()
		
	if Input.is_action_pressed("shoot") && _can_shoot && !_input_disabled:
		_shoot()
		if !$ShootSFX.playing:
			$ShootSFX.play()
		
	if Input.is_action_just_released("shoot"):
		$ShootSFX.stop()
		
func _shoot() -> void:
	var word = _word_list[_word_list_index]
	_word_list_index = posmod(_word_list_index - _dir_x, _word_list.size())
	var dir = Vector2(_dir_x, 0)
	
	var bullet = _bullet_pfb.instance()
	get_tree().current_scene.add_child(bullet)
	bullet.init(global_position, dir, word)
	_can_shoot = false
	$Cooldown.start()


func _on_Cooldown_timeout():
	_can_shoot = true
	pass # Replace with function body.

func _on_set_player_input_disabled(disabled: bool):
	_input_disabled = disabled
	if disabled:
		$ShootSFX.stop()
