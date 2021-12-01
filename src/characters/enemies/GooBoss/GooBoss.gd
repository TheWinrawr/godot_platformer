extends Area2D

signal damaged(health, max_health)
signal killed

export(float) var max_health = 500

var _health = max_health
var _player: Player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	_health = max_health
	pass # Replace with function body.
	
func _process(delta):
	if is_instance_valid(_player):
		_player.damage()

func damage():
	_health -= 1
	emit_signal("damaged", _health, max_health)
	if _health <= 0:
		emit_signal("killed")
		queue_free()


func _on_GooBoss_body_entered(body):
	if body is Player:
		_player = body


func _on_GooBoss_body_exited(body):
	if body is Player:
		_player = null
