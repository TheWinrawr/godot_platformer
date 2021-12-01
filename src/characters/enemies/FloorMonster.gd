extends Area2D

signal killed(monster_name)

export(float) var speed = 40

onready var _dir: Vector2 = Vector2.LEFT.rotated(rotation)

var _death_gibs = preload("res://src/characters/enemies/gibs/FloorMonsterDeath.tscn")

var _can_turn: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("walk")
	pass # Replace with function body.
	
func damage() -> void:
	emit_signal("killed", name)
	var gibs = _death_gibs.instance()
	gibs.global_position = global_position
	gibs.global_rotation = global_rotation
	get_parent().add_child(gibs)
	queue_free() # replace with death obj later


func turn() -> void:
	_dir *= -1
	_can_turn = false
	$Sprite.flip_h = !$Sprite.flip_h
	
func _physics_process(delta):
	var velocity = _dir * speed * delta
	position += velocity
	
	var on_edge = !$Left.is_colliding() || !$Right.is_colliding()
	if on_edge && _can_turn:
		turn()
	elif !on_edge:
		_can_turn = true

func _on_FloorMonster_area_entered(area):
	if area.has_method("damage"):
		area.damage(true)
	pass # Replace with function body.


func _on_GlitchBoxDetector_body_entered(body):
	if _can_turn:
		turn()

func _on_GlitchBoxDetector_body_exited(body):
	_can_turn = true
	pass # Replace with function body.
