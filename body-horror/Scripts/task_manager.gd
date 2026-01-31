extends Node2D

@export_group("task storage")
#We need a way of storing all of the possible tasks to be done
	#Ideally read from a text file so that code doesn't look ugly
#Also need a way of storing which tasks have been done and how they've been done
	#Could be done using a dictionary of task: completion
		#Completion can be not_done, ignored, done_well or done_poorly
		#Could be stored as an enum for optimisation
		#Then read said values and use this to determine how it drives the insanity of the character
		
enum completion{NOT_DONE, IGNORED, DONE_WELL, DONE_POORLY}
#Lowkey ugly but we can make things better later
var tasks:= {"Fetch the boss water": completion.NOT_DONE,
			"Print the files": completion.DONE_POORLY,
			"Check up on Naomi": completion.NOT_DONE}
			
func _ready() -> void:
	$ColorRect/ActualTaskList.text = "*" + str(tasks.keys()[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
