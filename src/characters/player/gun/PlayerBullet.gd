extends Area2D

var dir: Vector2 = Vector2.RIGHT
var _speed: float = 150
var _camera: Camera2D = null

var _glitch_block_destroy_sfx = preload("res://src/characters/player/gun/GlitchBlockDestroySFX.tscn")

func _ready() -> void:
	var cameras = get_tree().get_nodes_in_group("camera")
	if cameras.size() > 0:
		_camera = cameras[0]

func init(pos: Vector2, dir: Vector2, text: String):
	global_position = pos
	self.dir = dir
	$Label.text = text
	
	if dir == Vector2.RIGHT:
		$Label.align = Label.ALIGN_LEFT
		$Label.grow_horizontal = Control.GROW_DIRECTION_END
	elif dir == Vector2.LEFT:
		$Label.align = Label.ALIGN_RIGHT
		$Label.grow_horizontal = Control.GROW_DIRECTION_BEGIN

func _physics_process(delta):
	var velocity = _speed * dir * delta
	global_position += velocity
	
	if is_instance_valid(_camera):
		var extents = Vector2(160, 90)
		if global_position.x < _camera.global_position.x - extents.x || global_position.x > _camera.global_position.x + extents.x:
			queue_free()

func _on_PlayerBullet_area_entered(area):
	if area.has_method("damage"):
		area.damage()
		queue_free()


func _on_PlayerBullet_body_entered(body):
	if body is TileMap:
		if body.is_in_group("glitch_block"):
			_destroy_blocks(body)
			var audio = _glitch_block_destroy_sfx.instance()
			get_parent().add_child(audio)
		queue_free()

func _destroy_blocks(map: TileMap) -> void:
	var pos_list = []
	
	var extents = Vector2(3, 3)
	for i in range(-1, 2):
		for j in range(-1, 2):
			pos_list.append(Vector2(global_position.x + i * extents.x, global_position.y + j * extents.y))
	
	for p in pos_list:
		var tile_pos = map.world_to_map(p * (64.0 / 10.0))
		map.set_cellv(tile_pos, -1)
