extends ColorRect

export(float) var cell_size = 10
export(float) var cell_fade_time = 4
export(float, 1) var max_cell_brightness = 0.08
export(float, 1) var cell_frequency = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var max_length = max(rect_size.x, rect_size.y)
	rect_size = Vector2(max_length, max_length)
	
	material.set_shader_param("cell_size", cell_size / max_length)
	material.set_shader_param("fade_time", cell_fade_time)
	material.set_shader_param("max_brightness", max_cell_brightness)
	material.set_shader_param("cell_frequency", cell_frequency)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
