extends CharacterBody3D

@onready var anim_tree: AnimationTree = $"../AnimationTree"

#Triggering the end of a current task
func _on_area_3d_body_entered(body: Node3D) -> void:
	#Check to see if we even have started a task
	if body.is_in_group("player"):
		print("Finish task")
		if TaskManager.taskStarted:
			TaskManager.completeTask(0) #We update the insanity of Emily now

#NPC interaction - just need to figure out where exactly it should be
	#Preferably in above function but this depends on which tasks require what - for example check up on Naomi

func interact():
	# Just fire and forget; the UI will pick it up if it exists
		#This is a 2D array of the following format:
			#If true, this was the better option - heal their insanity
			#False - you chose the wrong action - cut down their insanity
	anim_tree["parameters/conditions/startConvo"] = true #We have indeed started a conversation
	GameManager.request_choices.emit([["Yes", true], ["No", false]])

#Triggering the start of a new task
