extends PlayerState

var _wall_normal: float = 0
var _wallslide_speed: float = 20
var _coyote_time: float = 0.1
var _coyote_time_left: float = 0
var _is_touching_wall: bool = true

func init(player: Player) -> void:
	pass
	
func enter(player: Player, prev_state: String = "") -> void:
	_wall_normal = -player.input_handler.horizontal
	_coyote_time_left = _coyote_time
	_is_touching_wall = true
	
func exit(player: Player) -> void:
	pass
	
func physics_update(player: Player, delta: float) -> String:
	player.velocity.x = player.input_handler.horizontal * player.speed
	player.apply_gravity(player.gravity, delta)
	if player.velocity.y > _wallslide_speed && _is_touching_wall:
		player.velocity.y = _wallslide_speed
	player.move()
	
	if player.input_handler.horizontal == _wall_normal:
		_is_touching_wall = false
	
	if !_is_touching_wall:
		_coyote_time_left -= delta
		if _coyote_time_left <= 0:
			return "Air"
			
		if player.is_on_wall() && player.input_handler.horizontal != 0:
			return "Wallslide"
			
	if player.input_handler.is_jump_pressed:
		return "Jump"
		
	if player.is_on_floor():
		if player.input_handler.horizontal == 0:
			return "Idle"
		else:
			return "Walk"
	return ""
