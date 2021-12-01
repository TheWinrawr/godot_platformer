var text_speed: float
var message_pause_time: float
var newline_after_message: bool
var arrow_prefix: bool

func _init(text_speed: float = 0.05, message_pause_time: float = 0.5, newline_after_message: bool = false, arrow_prefix: bool = false):
	self.text_speed = text_speed
	self.message_pause_time = message_pause_time
	self.newline_after_message = newline_after_message
	self.arrow_prefix = arrow_prefix
