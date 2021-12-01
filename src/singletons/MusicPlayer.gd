extends Node2D

enum Track {HAPPY_SONG, DARK_AMBIENCE, TREE_ROOM, GOO_BOSS, GODOT_BOSS, OMINOUS}

onready var _curr_track: AudioStreamPlayer = $TrackOne

var _tracks: Dictionary = {
	Track.HAPPY_SONG: preload("res://assets/audio/music/happy_song.ogg"),
	Track.DARK_AMBIENCE: preload("res://assets/audio/music/darklevel.ogg"),
	Track.TREE_ROOM: preload("res://assets/audio/music/tree_song.ogg"),
	Track.GOO_BOSS: preload("res://assets/audio/music/gooboss_theme.ogg"),
	Track.GODOT_BOSS: preload("res://assets/audio/music/godotboss_theme.ogg"),
	Track.OMINOUS: preload("res://assets/audio/music/ominous_music.ogg")
}

func _ready():
	pass

func play(track_num: int, fade_duration: float = 0, start_db: float = -20, start_time: float = 0):
	assert(_tracks.has(track_num), "Track %d does not exist" % track_num)
	
	var prev_track = _curr_track
	if _curr_track == $TrackOne:
		_curr_track = $TrackTwo
	else:
		_curr_track = $TrackOne
		
	_curr_track.stream = _tracks.get(track_num)
	_curr_track.play(start_time)
	_curr_track.volume_db = start_db
	
	$Tween.stop_all()
	$Tween.interpolate_property(_curr_track, "volume_db", start_db, 0, fade_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.interpolate_property(prev_track, "volume_db", prev_track.volume_db, -80, fade_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func stop(fade_duration: float = 0, end_db = -80):
	$Tween.stop_all()
	$Tween.interpolate_property($TrackOne, "volume_db", $TrackOne.volume_db, end_db, fade_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.interpolate_property($TrackTwo, "volume_db", $TrackTwo.volume_db, end_db, fade_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func get_playback_position() -> float:
	return _curr_track.get_playback_position()
