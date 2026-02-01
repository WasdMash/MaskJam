extends Node3D
# The % allows you to move the node in the scene tree without breaking the script
@export var creepy_sounds: Array[AudioStream] = [] #We want these to randomly play as insanity increases
@export var ooh_sound : AudioStream
var playingWTF := false

func _process(_delta: float) -> void:
	# 1. Only bother if we actually have sounds to play
	if creepy_sounds.is_empty(): return
	
	# 2. Probability check: higher insanity = higher chance
	# We multiply by delta so the frequency is consistent regardless of FPS
	# 0.1 is a "base" frequency; adjust this to make it rarer or more common
	var chance = GameManager.playerInsanity / 100
	
	if randf() < chance:
		play_random_creepy_sound()

func play_random_creepy_sound() -> void:
	# Pick a random sound from the array
	#Use cumulative random selection to appropiately pick audio
		#60 to 30 to 10 percent chance of normal to creep to wtf
	var chance = randf()
	var index = 2
	if chance < 0.6:
		index = 0
	elif chance < 0.7:
		index = 1
	var random_audio = creepy_sounds[index]
	var random_volume = randf()
	
	# We use a temporary player so sounds can overlap without cutting off
	var temp_player = AudioStreamPlayer3D.new()
	add_child(temp_player)
	
	temp_player.stream = random_audio
	temp_player.volume_db = (100 - GameManager.playerInsanity)/ 100
	temp_player.position = Vector3(randf_range(-40, 40), 0, randf_range(-40, 40)) # Random direction!
	temp_player.play()
	
	# Clean up the node once the sound finishes
	temp_player.finished.connect(temp_player.queue_free)
