extends Node

class_name PlayerInput

var horizontal: float = 0
var is_jump_pressed: bool = false
var is_jump_just_released: bool = false

var _input_disabled: bool = false setget set_input_disabled

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_input_disabled(disabled: bool) -> void:
	_input_disabled = disabled
	EventBus.emit_signal("set_player_input_disabled", disabled)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	horizontal = 0
	is_jump_pressed = false
	is_jump_just_released = false
	
	_handle_inputs()
	
func _handle_inputs() -> void:
	if _input_disabled:
		return
		
	if Input.is_action_pressed("left"):
		horizontal -= 1
	if Input.is_action_pressed("right"):
		horizontal += 1
	if Input.is_action_just_pressed("jump"):
		is_jump_pressed = true
	if Input.is_action_just_released("jump"):
		is_jump_just_released = true
		is_jump_pressed = false
	
