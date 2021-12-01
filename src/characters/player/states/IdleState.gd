extends "res://src/characters/player/states/GroundedState.gd"
	
func enter(player: Player, prev_state: String = "") -> void:
	player.velocity = Vector2.ZERO

func physics_update(player: Player, delta: float) -> String:
	player.apply_gravity(player.gravity, delta)
	player.move()
	if player.input_handler.is_jump_pressed:
		return "Jump"
	if player.input_handler.horizontal != 0:
		return "Walk"
	if !player.is_on_floor():
		return "Air"
	return ""
