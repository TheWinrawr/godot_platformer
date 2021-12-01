extends Node

class_name PlayerFSM

var _states: Dictionary = {}
var _active_state: PlayerState = null
var _player: Player = null

func init(player: Player):
	_player = player
	for state in get_children():
		_states[state.name] = state
		state.init(player)
	_active_state = _states["Air"]
	_active_state.enter(_player)

func physics_update(delta) -> void:
	var next_state = _active_state.physics_update(_player, delta)
	switch_state(next_state)

func switch_state(next_state: String) -> void:
	if _states.has(next_state):
		#print("STATE: %s -> %s" % [_active_state.name, next_state])
		var prev_state_name = _active_state.name
		
		_active_state.exit(_player)
		_active_state = _states[next_state]
		_active_state.enter(_player, prev_state_name)
