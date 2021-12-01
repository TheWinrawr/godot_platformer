extends Area2D

signal killed(monster_name)

export(float) var angular_speed = 360
export(float) var fly_radius = 30
export(float) var init_degree = 0
export(int, -1, 1, 2) var dir = 1

onready var _center: Vector2 = global_position
onready var _theta: float = init_degree

var _gibs = preload("res://src/characters/enemies/gibs/FlyingMonsterDeath.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func damage() -> void:
	emit_signal("killed", name)
	var gibs = _gibs.instance()
	gibs.global_position = global_position
	get_parent().add_child(gibs)
	queue_free() # replace with death obj later

func _physics_process(delta):
	_theta += deg2rad(angular_speed) * delta * dir
	var dir_vec = Vector2.RIGHT.rotated(_theta) * fly_radius
	global_position = _center + dir_vec


func _on_FlyingMonster_area_entered(area):
	if area.has_method("damage"):
		area.damage(true)
	pass # Replace with function body.
