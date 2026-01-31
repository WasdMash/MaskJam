extends MeshInstance3D

#Triggering the end of a current task
func _on_area_3d_body_entered(body: Node3D) -> void:
	#Check to see if we even have started a task
	if TaskManager.taskStarted:
		TaskManager.completeTask(0) #We update the insanity of Emily now
	#Lol, time to look at how much time it took, I guess?

#Triggering the start of a new task
func _on_area_3d_body_exited(body: Node3D) -> void:
	pass # Replace with function body.
