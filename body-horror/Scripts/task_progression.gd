extends MeshInstance3D
#Let's be mean and put a timer on the task
	#Depending on how quickly the bottle is given to the manager, we determine how well this task is done
#This max time should be unique based on the task
@export var maxTime := 20 #We shouldn't be spending more than 20 seconds on delivering paper
@export var taskName := "" #Set this in the editor per task

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		#Cool, now let's just trigger the task for now
		TaskManager.beginTask(taskName, maxTime)
		
func _process(delta: float) -> void:
	if TaskManager.taskStarted and TaskManager.taskTime < maxTime:
		TaskManager.taskTime += delta
	
