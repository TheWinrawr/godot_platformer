extends Control

onready var console = $Console/ScrollingText
onready var timer = $Timer

var step: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Console.visible = false
	console.max_lines = 18
	timer.start(15)
	pass # Replace with function body.


func _on_Timer_timeout():
	match step:
		0:
			ScreenShader.glitch(0.25, 0.1, 4, 150, 0.1, 1.5)
			yield(get_tree().create_timer(0.25), "timeout")
			$Console.visible = true
			$BSOD.visible = false
			timer.start(6)
		1:
			var messages = ["godot_platformer.exe [Godot 3.3 (Stable)]", "(c) WinRawr\n"]
			console.set_params(0.05, 0.5, true, false)
			console.write_all(messages)
		2:
			var messages = [
				"load Game.tscn", 
				"load ReadyScreen.tscn", 
				"set PLAYER.Controls = Game.InputHandler",
				"set PLAYER.Sprite = \"red_square.png\"",
				"set PLAYER.JumpSFX = \"jump_sfx.wav\""]

			console.set_params(0.05, 0.8, true, true)
			console.write_all(messages)
		3:
			var messages = ["    ERROR: FILE \"jump_sfx.wav\" load error (corrupted address @0x3b50f12e)"]
			console.set_params(0, 0.8, true, false)
			console.write_all(messages)
		4:
			var messages = [
				"load Coin.tscn",
				"set GAME.Camera = Camera.tscn", 
				"set GAME.Level = LevelOne.tscn", ]
			console.set_params(0.05, 0.8, true, true)
			console.write_all(messages)
		5:
			var messages = [
				"    ERROR: FILE \"LevelOne.tscn\" not found", 
				"    ERROR: FILE \"game_music.mp3\" not found",
				"    ERROR: FILE \"clouds.tres\" load error (GDScript.lang.NullPointerException)", 
				"    ERROR: FILE \"grass.tres\" load error (GDScript.lang.NullPointerException)",
				"    ERROR: Memory leak @0xb7714ef2: leaked 64 bytes at position 0x87539319", 
				"    ERROR: background.tres load failed (corrupted address @0x4bda82e1)",
				"    ERROR: AUTOLOAD EventBus.tscn load failed (corrupted address @0x195e0fb1)", 
				"    ERROR: FILE \"platform.tres\" load error (GDScript.lang.NullPointerException)",
				"    ERROR: FILE \"home.tres\" not found",
				"    ERROR: Memory leak @0x93c48d12: leaked 64 bytes at position 0x102938fe", 
				"    ERROR: AUTOLOAD MusicPlayer.tscn load failed (corrupted address @0x27ed0c1a)",
				"    ERROR: FILE \"bg_tilset.tres\" not found", 
				"    ERROR: Memory leak @0xb7724adf: leaked 16 bytes at position 0x10ef93c9",
				"    ERROR: Memory leak @0x145c4ff2: leaked 64 bytes at position 0x725a9cd9", 
				"    ERROR: FILE \"sky.tres\" load error (GDScript.lang.NullPointerException)",
				"    ERROR: FILE \"grass.png\" not found", 
				"    ERROR: FILE \"rocks.png\" not found",
				"    ERROR: AUTOLOAD GameManager.tscn load failed (corrupted address @0x135cafbd)", 
				"    ERROR: Memory leak @0x14dc4ae1: leaked 32 bytes at position 0x22cabfd9)",
				"    ERROR: FILE \"home.png\" not found",
				"    ERROR: Memory leak @0x9acc8dd2: leaked 64 bytes at position 0x3f29cdae", 
				"    ERROR: FILE Tree.tscn load failed (corrupted address @0x2afdcd13)"]
			console.set_params(0, 0.15, true, false)
			console.write_all(messages)
		6:
			get_parent().exit("DarkLevelEnter")
	
	step += 1


func _on_ScrollingText_queue_emptied():
	match step:
		2:
			timer.start(2)
		3:
			timer.start(0.1)
		4:
			timer.start(2)
		5:
			timer.start(4)
		6:
			console.clear()
			timer.start(4)
