extends Node

@export_group("Environmental variables")
#Need to track the player's insanity also
	#Should kinda reset each day but not entirely
	#Should decrease through the day - perhaps the more insane co-workers are, the more we lose our sanity
@export var playerInsanity := 100.0
@export var playerTweakValue := 0.25 #This will determine how slowly the player loses their mind
var insaneVignette : ShaderMaterial
var ogIntensity := 0.29
# Checks to see when a choice between two things is made - this shuold also alter insanity
signal choice_made(choice_id: String)
signal request_choices(options: Array)
	
@export_group("Office Clock")
@export var time_speed: float = 5.0 # Higher = faster work day
@export var current_day: int = 1 #Max day shou
var max_days:= 7
var current_hour: int = 9
var current_minute: float = 0.0
var is_transitioning := false

func get_vignette(vignette : ShaderMaterial) -> void:
	insaneVignette = vignette
	ogIntensity = insaneVignette.get_shader_parameter("intensity")

func start_next_day_sequence() -> void:
	is_transitioning = true
	await get_tree().create_timer(3.0).timeout
	
	# Reset for the new day
	current_hour = 9
	current_day += 1
	playerInsanity = 100.0 * current_day / 7
	is_transitioning = false # Resumes the _process clock
	#Cool
	TaskManager.currentTask.text = "Welcome to Day " + str(current_day)
	await get_tree().create_timer(0.5).timeout
	TaskManager.currentTask.text = "Time to look for a new task to do"
	TaskManager.pick_daily_tasks()
	TaskManager.updateTasks()

func _process(delta: float) -> void:
	# Tick the minutes based on frame time
	current_minute += delta * time_speed
	playerInsanity -= delta * playerTweakValue
	#Should be able to mess with the vignette intensity from here
	if insaneVignette:
		var target = playerInsanity * ogIntensity / 100.0
		# Use the material to get the value
		var current = insaneVignette.get_shader_parameter("intensity")
		insaneVignette.set_shader_parameter("intensity", lerp(current, target, 0.1))
		
	if current_minute >= 60.0:
		current_minute = 0.0
		current_hour += 1
		# Check for the end of the shift (6 PM / 18:00)
		if current_hour == 18:
			start_next_day_sequence()
