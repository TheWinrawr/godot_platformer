extends PlayerState

func enter(player: Player, prev_state: String = "") -> void:
	player.velocity = Vector2.ZERO
