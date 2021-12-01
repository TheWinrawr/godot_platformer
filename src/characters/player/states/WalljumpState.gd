extends PlayerState

var _jump_force: float = 0
var _max_jump_speed = 150

func init(player: Player) -> void:
	_jump_force = player.gravity * player.time_to_jump_apex
	
func enter(player: Player, prev_state: String = "") -> void:
	pass
	
func exit(player: Player) -> void:
	pass
	
func update(player: Player, delta: float) -> String:
	return ""
	
func physics_update(player: Player, delta: float) -> String:
	return ""
