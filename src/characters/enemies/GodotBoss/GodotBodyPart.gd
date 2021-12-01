extends Area2D

onready var boss = get_parent().get_parent()
onready var tween = boss.get_node("Tween")
var broken: bool = false

var glitch_shader = preload("res://src/resources/godot_damaged_part.tres")

func damage() -> void:
	boss.damage()
	tween.interpolate_property(self, "modulate", Color("ff6868"), Color.white, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	
func break_part() -> void:
	$CollisionPolygon2D.set_deferred("disabled", true)
	$Sprite.material = glitch_shader
	broken = true
	
func set_collision_disabled(disabled: bool) -> void:
	if broken:
		return
	$CollisionPolygon2D.set_deferred("disabled", disabled)
