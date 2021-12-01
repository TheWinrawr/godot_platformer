extends Area2D

var _dir: Vector2 = Vector2.RIGHT
var _speed: float = 200
var _rotate_speed: float = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(pos: Vector2, dir: Vector2, speed: float = 200, rotate_speed: float = 20):
	global_position = pos
	_dir = dir
	$Tween.interpolate_property(self, "_speed", 0, speed, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.interpolate_property(self, "_rotate_speed", rotate_speed, 0, 5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	
func _physics_process(delta):
	_dir = _dir.rotated(deg2rad(_rotate_speed) * delta)
	position += _speed * _dir * delta
	rotation = Vector2.RIGHT.angle_to(_dir)


func _on_EnemyBullet_body_entered(body):
	if body is Player:
		body.damage(false)
		queue_free()
	pass # Replace with function body.


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
