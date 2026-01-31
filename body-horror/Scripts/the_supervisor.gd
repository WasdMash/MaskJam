extends CharacterBody3D

@onready var navAgent : NavigationAgent3D = $NavigationAgent3D

#We want to be using the states here to control the movement of the character
func move_ai():
	print("We moving rn")
	var random_pos := Vector3.ZERO
	random_pos.x = randf_range(-50.0, 50.0)
	random_pos.x = randf_range(-50.0, 50.0)
	navAgent.set_target_position(random_pos)
	
func _process(_delta):
	await get_tree().create_timer(10.0).timeout
	move_ai()	
	
func _physics_process(delta: float) -> void:
	var destination = navAgent.get_next_path_position()
	var local_destiation = destination - global_position
	var direction = local_destiation.normalized()
	velocity = direction * 5.0
	move_and_slide()

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
