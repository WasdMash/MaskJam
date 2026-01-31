extends Node

@export_group("Environmental variables")
#Need to be able to track the insanity metres of each NPC
	#Emily. John , John Pork, Tyler and Naomi
#Basically, the higher their insanity, the wackier they will become
@export var insanities := [0,0,0,0,0]
#The following variables should increase either by each ask done or linearly#
	#If linearly, this should force the player to either make choices or annoy co-workers by doing nothing
@export var choiceControl : Control
	
@export_group("Office Clock")
@export var time_speed: float = 5.0 # Higher = faster work day
@export var current_day: int = 1 #Max day shou
var max_days:= 7
var current_hour: int = 9
var current_minute: float = 0.0

func _process(delta: float) -> void:
	# Tick the minutes based on frame time
	current_minute += delta * time_speed
	
	if current_minute >= 60.0:
		current_minute = 0.0
		current_hour += 1
		
		# Check for the end of the shift (6 PM / 18:00)
		if current_hour >= 18:
			current_hour = 9   # Back to work!
			current_day += 1   # Another day in the matrix
			print("Welcome to Day ", current_day, ". Get to your desk.")
