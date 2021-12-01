extends Node2D

class_name GodotBoss

enum Phase {FULL_HP, JAW_BROKEN, HEAD_BROKEN}

signal killed
signal damaged(health, max_health)
signal gravity_flipped(dir)
signal jaw_opened
signal jaw_closed

export(int) var max_health = 850

onready var anim_player_parts: AnimationPlayer = $AnimPlayerParts
onready var anim_player_visuals: AnimationPlayer = $AnimPlayerVisuals
onready var tween: Tween = $Tween
onready var left_eye_pos: Position2D = $Visuals/LeftEyePos
onready var right_eye_pos: Position2D = $Visuals/RightEyePos
onready var mouth_pos: Position2D = $Visuals/MouthPos

onready var _health: int = max_health

var _phase: int = Phase.FULL_HP
var _is_fighting: bool = false
var _prev_playback_pos: float = 0

var _bullet_pfb = preload("res://src/characters/enemies/attacks/EnemyBullet.tscn")
var _laser_pfb = preload("res://src/characters/enemies/attacks/Laser.tscn")
var _spinning_bullet_pfb = preload("res://src/characters/enemies/attacks/SpinningBullet.tscn")

var _eye_bullet_seconds: Array = []
var _laser_seconds: Array = []
var _mouth_bullet_seconds: Array = []
var _eye_bullet_index: int = 0
var _laser_index: int = 0
var _mouth_bullet_index: int = 0

var _laser_windup_time: float = 2

var _is_stunned: bool = false
var _is_dead: bool = false

var player: Player = null
var save_data = preload("res://src/resources/save data/godot_level.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	anim_player_parts.play("reset")
	anim_player_visuals.play("reset")
	
	for i in range(8, 54):
		_eye_bullet_seconds.append(i)
		_eye_bullet_seconds.append(i + 0.5)
		
	for i in range(96, 100):
		_eye_bullet_seconds.append(i)
		_eye_bullet_seconds.append(i + 0.5)
		
	for i in range(56, 96):
		for j in range(0, 8):
			_mouth_bullet_seconds.append(i + j / 8.0)
		
	_laser_seconds = [16, 18, 20, 23, 24, 26, 27, 28, 32, 34, 35, 36, 39, 40, 42, 43, 44, 72, 74, 75, 76, 80, 82, 83, 84, 85, 86, 87, 88, 90, 91, 92]
	for i in range(_laser_seconds.size()):
		_laser_seconds[i] -= _laser_windup_time
	
	_eye_bullet_seconds.append(10000)
	_mouth_bullet_seconds.append(10000)
	_laser_seconds.append(10000)
	
	player = Game.get_player()
	_set_colliders_disabled(true, true, true)
	
	if save_data.boss_phase == Phase.JAW_BROKEN:
		$Visuals/Jaw.break_part()
	elif save_data.boss_phase == Phase.HEAD_BROKEN:
		$Visuals/Jaw.break_part()
		$Visuals/Head.break_part()
	
	
func start(seconds: float) -> void:
	var sec = 0
	#save_data.boss_phase = Phase.HEAD_BROKEN
	
	if save_data.boss_phase == Phase.FULL_HP:
		sec = 0
		_health = 850
	elif save_data.boss_phase == Phase.JAW_BROKEN:
		sec = 48
		anim_player_visuals.play("bob")
		emit_signal("gravity_flipped", Vector2.DOWN)
		_health = 400
		_stun_boss()
	elif save_data.boss_phase == Phase.HEAD_BROKEN:
		sec = 8
		_health = 150
		_stun_boss()
		
	MusicPlayer.play(MusicPlayer.Track.GODOT_BOSS, 1, -20, sec)
	_is_fighting = true
	_prev_playback_pos = sec
	
	for i in range(_eye_bullet_seconds.size()):
		if _eye_bullet_seconds[i] >= sec:
			_eye_bullet_index = i
			break
	for i in range(_mouth_bullet_seconds.size()):
		if _mouth_bullet_seconds[i] >= sec:
			_mouth_bullet_index = i
			break
	for i in range(_laser_seconds.size()):
		if _laser_seconds[i] >= sec:
			_laser_index = i
			break
			
	_set_colliders_disabled(false, false, false)
	#_health = 10

func damage() -> void:
	_health -= 1
	emit_signal("damaged", _health, max_health)
	
	if _health == 400:
		_stun_boss()
		emit_signal("gravity_flipped", Vector2.DOWN)
		$Visuals/Jaw.break_part()
		save_data.boss_phase = Phase.JAW_BROKEN
	if _health == 150:
		_stun_boss()
		emit_signal("gravity_flipped", Vector2.UP)
		$Visuals/Head.break_part()
		save_data.boss_phase = Phase.HEAD_BROKEN
	if _health <= 0:
		kill()
		
func kill() -> void:
	if _is_dead:
		return
	_is_dead = true
	
	$Visuals/LeftEye.break_part()
	$Visuals/RightEye.break_part()
	_set_colliders_disabled(true, true, true)
	_stun_boss()
	_is_fighting = false
	MusicPlayer.stop()
	anim_player_parts.play("open_jaw")
	anim_player_visuals.play("shake")
	emit_signal("killed")
	emit_signal("jaw_closed")
	$SFX/Death.play()

func play_anim(anim_name: String) -> void:
	anim_player_parts.play(anim_name)

func _process(delta):
	_handle_anims()
	_handle_attacks()
	
	var seconds = MusicPlayer.get_playback_position()
	if seconds < _prev_playback_pos:
		_eye_bullet_index = 0
		_laser_index = 0
		_mouth_bullet_index = 0
		
	_prev_playback_pos = seconds
		
func _handle_anims() -> void:
	if !_is_fighting:
		return
		
	if _seconds_passed(0) || _seconds_passed(8) || _seconds_passed(92):
		anim_player_visuals.play("bob")
	elif _seconds_passed(54):
		anim_player_visuals.play("fade_out")
		_set_colliders_disabled(true, true, true)
	elif _seconds_passed(56):
		anim_player_visuals.play("shake", -1, 2)
		anim_player_parts.play("open_jaw")
		$Visuals/LeftEye.visible = false
		$Visuals/RightEye.visible = false
		_set_colliders_disabled(false, false, true)
		emit_signal("jaw_opened")
	elif _seconds_passed(72):
		$Visuals/LeftEye.visible = true
		$Visuals/RightEye.visible = true
		_set_colliders_disabled(false, false, false)
	elif _seconds_passed(96):
		anim_player_parts.play("close_jaw")
		emit_signal("jaw_closed")
		
func _handle_attacks():
	if !_is_fighting:
		return
		
	var seconds = MusicPlayer.get_playback_position()
		
	if seconds >= _eye_bullet_seconds[_eye_bullet_index]:
		_shoot_eye_bullets(2)
		_eye_bullet_index = (_eye_bullet_index + 1) % _eye_bullet_seconds.size()
#		if _eye_bullet_index == 0:
#			_eye_bullet_index = 1
		
	if seconds >= _laser_seconds[_laser_index]:
		_shoot_laser()
		_laser_index = (_laser_index + 1) % _laser_seconds.size()
		
	if seconds >= _mouth_bullet_seconds[_mouth_bullet_index]:
		_shoot_mouth_bullets(1)
		_mouth_bullet_index = (_mouth_bullet_index + 1) % _mouth_bullet_seconds.size()
		
#		if _seconds_passed(_mouth_bullet_seconds[_mouth_bullet_index]):
#			_shoot_mouth_bullets(1)
#			_mouth_bullet_index = (_mouth_bullet_index + 1) % _mouth_bullet_seconds.size()
		
func _shoot_eye_bullets(num_bullets: int) -> void:
	if _is_stunned:
		return
		
	var pos_list = [left_eye_pos, right_eye_pos]
	for p in pos_list:
		var dir: Vector2 = Vector2.RIGHT.rotated(2 * PI * randf())
		for n in num_bullets:
			dir = dir.rotated(2 * PI / num_bullets)
			var speed = 80
			var bullet = _bullet_pfb.instance()
			get_parent().add_child(bullet)
			bullet.init(p.global_position, dir, speed)
			bullet.rotation = Vector2.RIGHT.angle_to(dir)
			
func _shoot_laser() -> void:
	if !is_instance_valid(player) || _is_stunned:
		return
	
	var dir = Vector2.RIGHT
	if randf() < 0.5:
		dir = Vector2.UP
	
	var dir_list = [dir]
	if save_data.boss_phase == Phase.HEAD_BROKEN && MusicPlayer.get_playback_position() < 50:
		dir_list.append(Vector2.RIGHT.rotated(randf() * 2 * PI))
	for d in dir_list:
		var laser = _laser_pfb.instance()
		get_parent().add_child(laser)
		laser.init(player.global_position, d, _laser_windup_time)
		
func _shoot_mouth_bullets(num_bullets: int) -> void:
	if _is_stunned:
		return
		
	var dir: Vector2 = Vector2.RIGHT.rotated(2 * PI * randf())
	var speed = 120
	var rotate_speed = 60
	
	var seconds = MusicPlayer.get_playback_position()
	if seconds >= 64:
		rotate_speed *= -1
	if seconds >= 72:
		rotate_speed *= -1
	if seconds >= 82:
		rotate_speed *= -1
	if seconds >= 90 && randf() < 0.5:
		rotate_speed *= -1
	
	for n in num_bullets:
		var bullet = _spinning_bullet_pfb.instance()
		get_parent().add_child(bullet)
		bullet.init(mouth_pos.global_position, dir, speed, rotate_speed)
		dir = dir.rotated(2 * PI / num_bullets)
		
func _seconds_passed(seconds: float) -> bool:
	return seconds >= _prev_playback_pos && seconds < MusicPlayer.get_playback_position()

func _stun_boss() -> void:
	_is_stunned = true
	Game.clear_enemy_projectiles()
	$StunTimer.start()
	
func _on_StunTimer_timeout():
	_is_stunned = false

func _set_colliders_disabled(head: bool, jaw: bool, eyes: bool) -> void:
	$Visuals/Head.set_collision_disabled(head)
	$Visuals/Jaw.set_collision_disabled(jaw)
	$Visuals/LeftEye.set_collision_disabled(eyes)
	$Visuals/RightEye.set_collision_disabled(eyes)
