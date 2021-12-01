extends PlayerState

func physics_update(player: Player, delta: float) -> String:
	player.velocity.y += player.gravity * delta
	if !player.is_on_floor():
		return "Air"
	return ""
