tool

extends TileMap

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.editor_hint:
		global_scale = Vector2(0.15625, 0.15625)
	pass
