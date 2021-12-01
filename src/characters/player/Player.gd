extends KinematicBody2D

class_name Player

signal respawned
signal died

export(float) var speed = 100
export(float) var min_jump_height = 10
export(float) var max_jump_height = 55
export(float) var time_to_jump_apex = 0.5

onready var input_handler: PlayerInput = $InputHandler
onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var fsm = $PlayerFSM

var _max_health: int = 3
var _health: int = _max_health

var velocity: Vector2 = Vector2.ZERO
var gravity: float = 0
var up_dir: Vector2 = Vector2.UP

var _invincible: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.set_player(self)
	gravity = 2 * max_jump_height / pow(time_to_jump_apex, 2)
	
	$PlayerFSM.init(self)
	pass # Replace with function body.
	
func freeze() -> void:
	fsm.switch_state("Freeze")
	
func unfreeze() -> void:
	fsm.switch_state("Air")
	
func respawn() -> void:
	emit_signal("respawned")
	$PlayerFSM.switch_state("Air")
	set_collisions_disabled(true)
	anim_player.play("hit")
	input_handler.set_input_disabled(false)
	
func die() -> void:
	$SFX/Death.play()
	var freeze_duration = 2.5
	ScreenShader.glitch(freeze_duration)
	ScreenShader.noise(freeze_duration)
	fsm.switch_state("Freeze")
	anim_player.play("die")
	
func heal(heal_amt: int) -> void:
	if _health < _max_health:
		$SFX/Heal.play()
	_health = clamp(_health + heal_amt, 0, _max_health)
	
func damage(respawn_at_checkpoint: bool = false) -> void:
	if _invincible:
		return
	_invincible = true
	_health -= 1
	$SFX/Hit.play()
	
	if _health <= 0:
		die()
		input_handler.set_input_disabled(true)
	elif respawn_at_checkpoint:
		fsm.switch_state("Freeze")
		anim_player.play("hit_then_respawn")
		ScreenShader.glitch(0.25, 0.1, 4, 40)
		input_handler.set_input_disabled(true)
	else:
		ScreenShader.glitch(0.25, 0.1, 4, 40)
		anim_player.play("hit")
	
func move() -> void:
	velocity = move_and_slide(velocity, up_dir)
	
func jump(jump_force: float) -> void:
	velocity.y = jump_force * up_dir.y

func apply_gravity(gravity: float, delta: float) -> void:
	velocity += gravity * delta * -up_dir
	
func _process(delta):
	if _health > 2:
		$Sprite.frame = 0
	elif _health == 2:
		$Sprite.frame = 1
	else:
		$Sprite.frame = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$PlayerFSM.physics_update(delta)
	
func set_collisions_disabled(disabled: bool) -> void:
	#$GlitchBlockDetector/CollisionShape2D.set_deferred("disabled", disabled)
	#$GlitchBlockDetector/CollisionShape2D2.set_deferred("disabled", disabled)
	$Hurtbox/CollisionShape2D.set_deferred("disabled", disabled)

func _on_GlitchBlockDetector_body_entered(body):
	_invincible = false
	damage(true)
	pass # Replace with function body.


func _on_animation_finished(anim_name):
	if anim_name == "hit_then_respawn":
		respawn()
	if anim_name == "hit":
		_invincible = false
		set_collisions_disabled(false)
	if anim_name == "die":
		emit_signal("died")
	pass # Replace with function body.


func _on_GlitchShaderTimer_timeout():
	if _health == _max_health:
		$GlitchShader/GlitchShaderTimer.start(1)
	else:
		$GlitchShader/GlitchShader.visible = true
		$GlitchShader/GlitchDuration.start(0.3)


func _on_GlitchDuration_timeout():
	$GlitchShader/GlitchShader.visible = false
	if _health > 2:
		$GlitchShader/GlitchShaderTimer.start(1)
	elif _health == 2:
		$GlitchShader/GlitchShaderTimer.start(1 + randf() * 1)
	elif _health == 1:
		$GlitchShader/GlitchShaderTimer.start(0.1 + randf() * 0.4)
