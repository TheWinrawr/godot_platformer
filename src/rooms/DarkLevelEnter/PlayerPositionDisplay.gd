extends Label

enum Axis {X, Y}

export(Axis) var axis = Axis.X

onready var _player: Player = get_parent().get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "NULL"
	if is_instance_valid(_player):
		if axis == Axis.X:
			text = "%d" % _player.global_position.x
		elif axis == Axis.Y:
			text = "%d" % _player.global_position.y
