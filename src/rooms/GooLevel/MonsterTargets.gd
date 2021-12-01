extends Node2D

var monsters_killed: PoolStringArray = []

onready var _num_monsters: int = get_child_count() - 2

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in self.get_children():
		if node.has_signal("killed"):
			node.connect("killed", self, "_on_monster_killed")

func _on_monster_killed(monster_name: String) -> void:
	monsters_killed.append(monster_name)
	_update_text()
	if monsters_killed.size() >= _num_monsters:
		$GooBossBlock.queue_free()

func reload_with_data(data: RoomSaveData) -> void:
	for monster_name in data.monsters_killed:
		if has_node(monster_name):
			get_node(monster_name).queue_free()
	monsters_killed = data.monsters_killed
	_update_text()
	
	if monsters_killed.size() >= _num_monsters:
		$GooBossBlock.queue_free()
	
func _update_text() -> void:
	for label in $Labels.get_children():
		label.text = "%d" % [_num_monsters - monsters_killed.size()]
