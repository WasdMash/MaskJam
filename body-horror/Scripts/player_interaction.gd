extends Node3D

#Need to get states of what the player is doing
@export_group("Miscellaneous variables")
enum states{WALKING, DOING_TASK, TALKING}
enum wellbeing{NORMAL,CREEP,WTF}
@export var insanity:= 0
@export var max_insanity:= 100
@export var currentState := states.WALKING #Just assume that the player is walking around
#Will need to activate and de-activate movement depending on the state
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if currentState == states.WALKING:
		#Enable the player movement if disabled
			#Play their walking animation
		#Disable the current task UI
		GameManager.choiceControl.visible = false #.process_mode = PROCESS_MODE_DISABLED shouldn't be necessary
		pass
	elif currentState == states.DOING_TASK:
		#Need to check if the task is done well - should alter the insanity of those around us
		#Need to find out which task they are doing and do its animation here also
			#As it increases, we increase the odds of playing a flashback or random creepy sounds
		pass
	else:
		#Disable the player movement and freeze the NPCs in the background
			#That except the one who we are talking to
		GameManager.choiceControl.visible = true
		pass
