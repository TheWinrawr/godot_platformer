extends PlayerState

var _jump_force: float = 0

func init(player: Player) -> void:
	_jump_force = player.gravity * player.time_to_jump_apex
	
func enter(player: Player, prev_state: String = "") -> void:
	$HappyJumpSFX.play()
	$NotHappyJumpSFX.play()
	player.jump(_jump_force)
	
func physics_update(player: Player, delta: float) -> String:
	player.apply_gravity(player.gravity, delta)
	player.move()
	return "Air"
