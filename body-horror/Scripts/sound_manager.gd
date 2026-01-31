extends Control

func _ready():
	play_background_music()

func play_background_music():
	$BackgroundMusic.play()
	
func pause_background_music():
	$BackgroundMusic.stop()
