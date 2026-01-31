extends Node3D
# The % allows you to move the node in the scene tree without breaking the script
@export var creepy_sounds: Array[AudioStream] = [] #We want these to randomly play as insanity increases

func _process(_delta: float) -> void:
	# 1. Only bother if we actually have sounds to play
	if creepy_sounds.is_empty(): return
	
	# 2. Probability check: higher insanity = higher chance
	# We multiply by delta so the frequency is consistent regardless of FPS
	# 0.1 is a "base" frequency; adjust this to make it rarer or more common
	var chance = (100 - GameManager.playerInsanity) / 100
	
	if randf() < chance:
		play_random_creepy_sound()

func play_random_creepy_sound() -> void:
	# Pick a random sound from the array
	var random_audio = creepy_sounds.pick_random()
	var random_volume = randf()
	
	# We use a temporary player so sounds can overlap without cutting off
	var temp_player = AudioStreamPlayer3D.new()
	add_child(temp_player)
	
	temp_player.stream = random_audio
	temp_player.volume_db = GameManager.playerInsanity/ 100
	temp_player.position = Vector3(randf_range(-40, 40), 0, randf_range(-40, 40)) # Random direction!
	temp_player.play()
	
	# Clean up the node once the sound finishes
	temp_player.finished.connect(temp_player.queue_free)
