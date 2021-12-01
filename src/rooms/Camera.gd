tool

extends Camera2D

enum Mode {STEP, FOLLOW_PLAYER}

export(Mode) var mode = Mode.STEP

onready var _resolution: Vector2 = get_viewport_rect().size
onready var _offset: Vector2 = _resolution / 2
onready var _prev_position: Vector2 = global_position

var target: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.set_camera(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_camera()

func move_camera() -> void:
	if Engine.editor_hint && mode == Mode.STEP:
		var resolution = Vector2(320, 180)
		global_position = resolution / 2 + Vector2(floor(global_position.x / resolution.x), floor(global_position.y / resolution.y)) * resolution
	elif is_instance_valid(target):
		global_position = _offset + Vector2(floor(target.global_position.x / _resolution.x), floor(target.global_position.y / _resolution.y)) * _resolution
		if global_position != _prev_position:
			EventBus.emit_signal("camera_moved")
		_prev_position = global_position
	pass
