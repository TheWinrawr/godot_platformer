extends Area2D

var _hitbox_duration: float = 0.2
var _hitbox_active: bool = false

func init(pos: Vector2, dir: Vector2, windup_time: float) -> void:
	global_position = pos
	global_rotation = Vector2.RIGHT.angle_to(dir)
	
	$Tween.interpolate_property($Windup, "modulate:a", 0, 1, windup_time - 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.interpolate_callback(self, windup_time, "_shoot")
	$Tween.start()

func _on_Laser_body_entered(body):
	if body is Player && _hitbox_active:
		body.damage(false)
		
func _shoot() -> void:
	_hitbox_active = true
	$Timer.start(_hitbox_duration)
	$CollisionShape2D.set_deferred("disabled", false)
	
	$Windup.visible = false
	$Sprite.visible = true
	$FreeTimer.start()
	$Tween.interpolate_property($Sprite, "modulate:a", 1, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func _on_Timer_timeout():
	_hitbox_active = false

func _on_FreeTimer_timeout():
	queue_free()
	pass # Replace with function body.
