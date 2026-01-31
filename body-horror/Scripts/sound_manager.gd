extends Control

@export_group("Songs")
@export var playlist: Array[AudioStream] = []
var current_index: int = 0

# The % allows you to move the node in the scene tree without breaking the script
@export var music_player: AudioStreamPlayer

func _ready() -> void:
	if playlist.is_empty():
		return	
	# Connect the child's signal to a function in this parent script
	music_player.finished.connect(_play_next_track)
	_play_track(0)

func _play_track(index: int) -> void:
	current_index = index
	music_player.stream = playlist[current_index]
	music_player.play()

func _play_next_track() -> void:
	# Modulo (%) wraps the index back to 0 at the end of the list
	var next_index = (current_index + 1) % playlist.size()
	_play_track(next_index)
