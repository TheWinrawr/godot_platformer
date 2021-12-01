extends Node2D

func _ready():
	ScreenShader.set_shader(self)

func glitch(duration: float, shake_power: float = 0.1, shake_rate: float = 8, n_stripes: float = 80, chrom_aberr: float = 0.02, opacity: float = 0.5) -> void:
	$Glitch.material.set_shader_param("shake_power", shake_power)
	$Glitch.material.set_shader_param("shake_rate", shake_rate)
	$Glitch.material.set_shader_param("n_stripes", n_stripes)
	$Glitch.material.set_shader_param("chromatic_aberration", chrom_aberr)
	$Glitch.material.set_shader_param("rgb_opacity", opacity)
	
	$Tween.interpolate_property($Glitch, "visible", true, false, duration * 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	
func pixelate(duration: float) -> void:
	pass

func noise(duration: float) -> void:
	$Tween.interpolate_property($Noise, "visible", true, false, duration * 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.interpolate_property($Noise, "modulate", Color(1.0, 1.0, 1.0, 0.0), Color(1.0, 1.0, 1.0, 1.0), duration * 0.7, Tween.TRANS_SINE, Tween.EASE_IN)
	$Tween.start()

func noise_instant(duration: float, opacity: float = 1) -> void:
	$Noise.modulate.a = opacity
	$Tween.interpolate_property($Noise, "visible", true, false, duration * 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
