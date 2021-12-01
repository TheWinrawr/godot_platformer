extends Area2D

var player: Player = null
var _flying: bool = false

func _on_Lift_body_entered(body):
	if body is Player:
		player = body
		_flying = true
		$Timer.start()
		
func _physics_process(delta):
	if _flying && is_instance_valid(player):
		player.velocity.y = -200

func _on_Timer_timeout():
	if is_instance_valid(player):
		_flying = false
