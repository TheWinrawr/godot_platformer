extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "%d" % (get_parent().up_dir.y * -1)
	pass
