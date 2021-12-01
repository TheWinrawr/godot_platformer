extends Area2D

var player: Player = null
var up_dir: Vector2 = Vector2.UP

func _on_GravityArea_body_entered(body):
	if body is Player:
		player = body
		player.up_dir = up_dir

func _on_GravityTimer_timeout():
	up_dir *= -1
	if is_instance_valid(player):
		player.up_dir = up_dir

func _on_GravityArea_body_exited(body):
	if body is Player:
		player.up_dir = Vector2.UP
		player = null
