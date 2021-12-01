extends Node

class_name PlayerState

func init(player: Player) -> void:
	pass
	
func enter(player: Player, prev_state: String = "") -> void:
	pass
	
func exit(player: Player) -> void:
	pass
	
func update(player: Player, delta: float) -> String:
	return ""
	
func physics_update(player: Player, delta: float) -> String:
	return ""
