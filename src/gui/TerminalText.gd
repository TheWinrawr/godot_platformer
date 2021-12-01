extends Node2D

export(String, MULTILINE) var messages
export(int, 20) var max_lines = 20

onready var _messages: Array = Array(messages.split("\n"))
# Called when the node enters the scene tree for the first time.
func _ready():
	_messages.shuffle()
	$ScrollingText.max_lines = max_lines
	$ScrollingText.set_params(0.01, 0, true, true)
	$ScrollingText.write_all(_messages)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ScrollingText_queue_emptied():
	_messages.shuffle()
	$ScrollingText.write_all(_messages)
