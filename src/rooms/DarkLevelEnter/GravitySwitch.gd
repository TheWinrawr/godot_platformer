extends Node2D

signal flipped(up_dir)

var save_data: RoomSaveData = preload("res://src/resources/save data/dark_level_enter.tres")

func reload() -> void:
	if save_data.gravity_coin_collected && !save_data.gravity_area_escaped:
		emit_signal("flipped", Vector2.DOWN)


func _on_GravityCoin_collected():
	ScreenShader.glitch(0.5)
	emit_signal("flipped", Vector2.DOWN)
	$GlitchSFX.play()

func _on_gravity_save_point_saved():
	if save_data.gravity_coin_collected && !save_data.gravity_area_escaped:
		save_data.gravity_area_escaped = true
		emit_signal("flipped", Vector2.UP)
		ScreenShader.glitch(0.5)
		$GlitchSFX.play()
	pass # Replace with function body.
