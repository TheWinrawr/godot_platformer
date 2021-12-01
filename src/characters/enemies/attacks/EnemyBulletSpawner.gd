extends Node2D

export(float) var bullet_speed = 200
export(int) var num_bullets = 6
export(Vector2) var dir = Vector2.RIGHT

var _bullet_pfb = preload("res://src/characters/enemies/attacks/EnemyBullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(bullet_speed: float = 200, num_bullets: int = 6, dir: Vector2 = Vector2.RIGHT):
	self.bullet_speed = bullet_speed
	self.num_bullets = num_bullets
	self.dir = dir
	
func spawn_bullets(warning_time: float = 1) -> void:
	$Tween.interpolate_property($Sprite, "modulate:a", 0, 1, warning_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func _on_Tween_tween_all_completed():
	if num_bullets <= 0:
		return
		
	for n in num_bullets:
		dir = dir.rotated(2 * PI / num_bullets * n)
		var bullet = _bullet_pfb.instance()
		get_parent().add_child(bullet)
		bullet.init(global_position, dir, bullet_speed)
		
	queue_free()
