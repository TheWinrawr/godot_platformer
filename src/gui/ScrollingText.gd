extends Control

signal queue_emptied

export(float) var text_speed = 0.05
export(float) var message_pause_time = 0.5
export(bool) var newline_after_message = false
export(bool) var arrow_prefix = false

var max_lines: int = 100

var _text: String = ""

var _message_queue: PoolStringArray = []
var _curr_message: String = ""
var _char_index: int = 0
var _is_writing: bool = false

var _time_until_next_char: float = 0

var _blip_duration: float = 0.1
var _time_until_next_blip: float = 0

func set_params(text_speed: float = 0.05, message_pause_time: float = 0.5, newline_after_message: bool = false, arrow_prefix: bool = false) -> void:
	self.text_speed = text_speed
	self.message_pause_time = message_pause_time
	self.newline_after_message = newline_after_message
	self.arrow_prefix = arrow_prefix
	
func clear() -> void:
	_is_writing = false
	_text = ""
	_curr_message = ""
	$Label.text = ""
	$MessageTimer.stop()

func write(message: String) -> void:
#	if params:
#		text_speed = params.text_speed
#		message_pause_time = params.message_pause_time
#		newline_after_message = params.newline_after_message
#		arrow_prefix = params.arrow_prefix
		
	_message_queue.append(message)
	if _curr_message.length() == 0:
		_next_message()
		
func write_all(messages: Array) -> void:
	for message in messages:
		write(message)
	
func _next_message() -> void:
	_is_writing = false
	if _message_queue.empty():
		_curr_message = ""
		emit_signal("queue_emptied")
		return
		
	var pause_time = message_pause_time
	if _curr_message.length() == 0:
		pause_time = 0.01
		
	_curr_message = _message_queue[0]
	_char_index = 0
	_message_queue.remove(0)
	
	$MessageTimer.start(pause_time)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_write_char(delta)
	$Label.text = _text

func _write_char(delta: float) -> void:
	if _is_writing:
		if text_speed <= 0:
			_text += _curr_message.substr(_char_index)
			_next_message()
			return
		if _char_index >= _curr_message.length():
			_next_message()
		_time_until_next_char -= delta
		if _time_until_next_char <= 0:
			_time_until_next_char = text_speed
			_text += _curr_message[_char_index]
			_char_index += 1
			if _char_index >= _curr_message.length():
				_next_message()

func _on_MessageTimer_timeout():
	if newline_after_message:
		if _text.length() != 0:
			_text += "\n"
	else:
		_text = ""
		
	if arrow_prefix:
		_text += ">> "
	
	var num_lines = _text.count("\n")
	if num_lines >= max_lines:
		var index = _text.find("\n")
		_text = _text.substr(index + 1)
		
	_is_writing = true
	
class ScrollingTextParams:
	var text_speed: float
	var message_pause_time: float
	var newline_after_message: bool
	var arrow_prefix: bool
	
	func _init(text_speed: float = 0.05, message_pause_time: float = 0.5, newline_after_message: bool = false, arrow_prefix: bool = false):
		self.text_speed = text_speed
		self.message_pause_time = message_pause_time
		self.newline_after_message = newline_after_message
		self.arrow_prefix = arrow_prefix
