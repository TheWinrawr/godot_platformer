extends Area2D

var _dir: Vector2 = Vector2.RIGHT
var _speed: float 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(pos: Vector2, dir: Vector2, speed: float = 200):
	global_position = pos
	_dir = dir
	_speed = speed
	
func _physics_process(delta):
	position += _speed * _dir * delta


func _on_EnemyBullet_body_entered(body):
	if body is Player:
		body.damage(false)
		queue_free()
	pass # Replace with function body.


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
