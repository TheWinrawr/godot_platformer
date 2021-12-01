extends Node2D

onready var ready_screen: Control = $Control/ReadyScreen

var room_path: String = "res://src/rooms"
var room_names = [
	"HappyLevel",
	"ErrorScreen",
	"DarkLevelEnter",
	"GooLevel",
	"CoinRoom",
	"GodotLevel",
	"EndRoom"
]

var rooms: Dictionary = {}

var _curr_room: Room = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for room_name in room_names:
		rooms[room_name] = load("%s/%s/%s.tscn" % [room_path, room_name, room_name])
	_load_room("", "HappyLevel")
	
func reload_room(room_name: String) -> void:
	if is_instance_valid(_curr_room):
		_curr_room.queue_free()
		
	ready_screen.display(room_name)
	ready_screen.visible = true
	MusicPlayer.stop()
	yield(get_tree().create_timer(1.5), "timeout")
	ready_screen.visible = false
	
	call_deferred("_load_room", "", room_name)

func level_transition(from_room: String, to_room: String) -> void:
	assert(rooms.has(from_room), "Room name %s does not exist" % [from_room])
	assert(rooms.has(to_room), "Room name %s does not exist" % [to_room])
	
	call_deferred("_load_room", from_room, to_room)
	
func _load_room(from_room: String, to_room: String) -> void:
	if is_instance_valid(_curr_room):
		_curr_room.queue_free()
		yield(get_tree(), "idle_frame")
	_curr_room = rooms[to_room].instance()
	_curr_room.connect("exited", self, "level_transition")
	_curr_room.connect("reloaded", self, "reload_room")
	add_child(_curr_room)
	
	var save_data = $SaveData.data.get(to_room)
	_curr_room.enter(from_room, save_data)
