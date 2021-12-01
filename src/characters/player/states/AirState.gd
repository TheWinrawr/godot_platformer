extends PlayerState

var _max_air_jumps: int = 0
var _num_air_jumps: int = 0
var _coyote_time: float = 0.15
var _coyote_time_left: float = 0
var _min_jump_force: float = 0
var _terminal_velocity: float = 300

func init(player: Player) -> void:
	_min_jump_force = sqrt(2* player.gravity * player.min_jump_height)
	
func enter(player: Player, prev_state: String = "") -> void:
	if prev_state == "Jump":
		_coyote_time_left = 0
	else:
		_coyote_time_left = _coyote_time
	
func physics_update(player: Player, delta: float) -> String:
	player.velocity.x = player.input_handler.horizontal * player.speed
	var gravity = player.gravity
	if player.velocity.y * -player.up_dir.y > 0:
		gravity *= 1.5
	player.apply_gravity(gravity, delta)
	if player.velocity.y * -player.up_dir.y > _terminal_velocity:
		player.velocity.y = _terminal_velocity * -player.up_dir.y
	player.move()
	
	_coyote_time_left -= delta
	
	if player.input_handler.is_jump_just_released && player.velocity.y * -player.up_dir.y < -_min_jump_force:
		player.jump(_min_jump_force)
		
#	if player.is_on_wall() && player.input_handler.horizontal != 0:
#		return "Wallslide"
	
	if player.input_handler.is_jump_pressed:
		if _coyote_time_left > 0:
			return "Jump"
		elif _num_air_jumps < _max_air_jumps:
			_num_air_jumps += 1
			return "Jump"
	
	if player.is_on_floor():
		_num_air_jumps = 0
		_coyote_time_left = _coyote_time
		if player.input_handler.horizontal == 0:
			return "Idle"
		else:
			return "Walk"
	return ""
