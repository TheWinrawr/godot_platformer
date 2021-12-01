extends Node2D

var text: String = "extends Area2D var dir: Vector2 = Vector2.RIGHT var _speed: float = 300 func _physics_process (delta) : var velocity = _speed * dir * delta position += velocity func _on_area_entered (area): if area.has_method (\"damage\"): area.damage () queue_free () func _on_body_entered (body): if body is TileMap: if body is GlitchTileMap: _destroy_blocks (body) queue_free() func _destroy_blocks (map: TileMap) -> void: var pos_list = [] var extents = Vector2 (3, 3) for i in range (-1, 2): for j in range (-1, 2): pos_list .append (Vector2 (position.x + i * extents.x, position.y + j * extents.y)) for p in pos_list: var tile_pos = map .world_to_map (p * (64.0 / 10.0)) map .set_cellv (tile_pos, -1)"
var word_list: Array = text.split(" ")
