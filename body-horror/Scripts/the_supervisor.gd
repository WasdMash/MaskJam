extends CharacterBody3D


#Triggering the end of a current task
func _on_area_3d_body_entered(body: Node3D) -> void:
	#Check to see if we even have started a task
	if body.is_in_group("player") and TaskManager.currentTaskName != "":
		print("Finish task")
		if TaskManager.taskStarted:
			TaskManager.completeTask() #We update the insanity of Emily now

#NPC interaction - just need to figure out where exactly it should be
	#Preferably in above function but this depends on which tasks require what - for example check up on Naomi

#Triggering the start of a new task
