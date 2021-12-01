extends Node

var shaders: Node2D = null

func set_shader(_shaders: Node2D) -> void:
	shaders = _shaders

func glitch(duration: float, shake_power: float = 0.1, shake_rate: float = 8, n_stripes: float = 80, chrom_aberr: float = 0.02, opacity: float = 0.5) -> void:
	shaders.glitch(duration, shake_power, shake_rate, n_stripes, chrom_aberr, opacity)

func noise(duration: float) -> void:
	shaders.noise(duration)

func noise_instant(duration: float, opacity: float = 1) -> void:
	shaders.noise_instant(duration, opacity)
