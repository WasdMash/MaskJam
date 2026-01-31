extends MeshInstance3D

#Triggering the end of a current task
func _on_area_3d_body_entered(body: Node3D) -> void:
	#Check to see if we even have started a task
	if TaskManager.taskStarted:
		TaskManager.completeTask(0) #We update the insanity of Emily now

#NPC interaction - just need to figure out where exactly it should be
	#Preferably in above function but this depends on which tasks require what - for example check up on Naomi
"""
func interact():
    # Just fire and forget; the UI will pick it up if it exists
		#This is a 2D array of the following format:
			#If true, this was the better option - heal their insanity
			#False - you chose the wrong action - cut down their insanity
    GameManager.request_choices.emit([["Yes", true], ["No", false]])
"""

#Triggering the start of a new task
func _on_area_3d_body_exited(body: Node3D) -> void:
	pass # Replace with function body.
