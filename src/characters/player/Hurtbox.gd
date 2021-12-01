extends Area2D

func damage(respawn_at_checkpoint: bool = false) -> void:
	get_parent().damage(respawn_at_checkpoint)
