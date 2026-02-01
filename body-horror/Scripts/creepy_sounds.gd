extends Node3D
# The % allows you to move the node in the scene tree without breaking the script
@export var creepy_sounds: Array[AudioStream] = [] #We want these to randomly play as insanity increases
@export var ooh_sound : AudioStream
var playingWTF := false
@export var waitTime := 10.0

func _ready() -> void:
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = waitTime
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
func _on_timer_timeout() -> void:
	if creepy_sounds.is_empty(): return
	
	# 2. Probability check: higher insanity = higher chance
	# We multiply by delta so the frequency is consistent regardless of FPS
	# 0.1 is a "base" frequency; adjust this to make it rarer or more common
	var chance = (100 - GameManager.playerInsanity) / 100
	if randf() > chance:
		play_random_creepy_sound()

func play_random_creepy_sound() -> void:
	var chance = (100 - GameManager.playerInsanity) / 100
	var index = 2
	if chance < 0.6:
		index = 0
	elif chance < 0.9:
		index = 1
	var random_audio = creepy_sounds[index]
	var random_volume = randf()
	
	# We use a temporary player so sounds can overlap without cutting off
	var temp_player = AudioStreamPlayer3D.new()
	add_child(temp_player)
	
	temp_player.stream = random_audio
	temp_player.volume_db = linear_to_db(chance) 
	print(temp_player.stream.resource_path.get_basename() + " : " + str(temp_player.volume_db))
	temp_player.position = Vector3(randf_range(-20, 20), 0, randf_range(-20, 20)) # Random direction!
	temp_player.play()
	
	# Clean up the node once the sound finishes
	temp_player.finished.connect(temp_player.queue_free)
