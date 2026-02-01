extends Node2D

@export_group("task storage")
#We need a way of storing all of the possible tasks to be done
	#Ideally read from a text file so that code doesn't look ugly
#Also need a way of storing which tasks have been done and how they've been done
	#Could be done using a dictionary of task: completion
		#Completion can be not_done, ignored, done_well or done_poorly
		#Could be stored as an enum for optimisation
		#Then read said values and use this to determine how it drives the insanity of the character
var taskList: Label

@export_group("Task completion stats")
@export var taskTime := 0.0 #This will be handled by delta so it should be a float
@export var taskStarted := false
@export var currentTaskName := ""
@export var currentMaxTaskTime := 0

@export_group("Insanities")
#Need to be able to track the insanity metres of each NPC
	#Emily. John , John Pork, Tyler and Naomi
#Basically, the higher their insanity, the wackier they will become
@export var insanities := [100,100,100,100,100] #Everyone starts kinda sane but you can make it worse
enum wellbeing{NORMAL,CREEP,WTF}

func beginTask(taskName: String, taskMaxTime : float) -> void:
	taskStarted = true
	currentTaskName = taskName
	currentMaxTaskTime = taskMaxTime
	print(currentTaskName)
	
func completeTask(insanityIndex : int):
	#Now we can complete said task
	#Calculate its insanity and then alter the insanity of the relevant character
	taskStarted = false #stop the timer
	var insanityCheck = taskTime / currentMaxTaskTime
	var taskCompletionType = completion.NOT_DONE
	insanities[insanityIndex] *= (1 - insanityCheck) #The faster the tasks are done, the less insane they become
	if insanityCheck > 0.5:
		taskCompletionType = completion.DONE_WELL
	elif insanityCheck > 0.3:
		taskCompletionType = completion.DONE_POORLY
	#Should update the task list to accommodate this new change
	tasks[currentTaskName] = taskCompletionType
	updateTasks()
	
func register_task_label(label_node: Label):
	taskList = label_node
	updateTasks() # Initial fill of the list
		
enum completion{NOT_DONE, IGNORED, DONE_WELL, DONE_POORLY}
#Lowkey ugly but we can make things better later
var tasks:= {"Fetch the boss water": completion.NOT_DONE,
			"Print the files": completion.NOT_DONE,
			"Check up on Naomi": completion.NOT_DONE}
	
#This is the function to be ran to update the task list
func updateTasks():
	taskList.text = ""
	for task in tasks:
		var progress = tasks[task]
		if progress == completion.NOT_DONE:
			taskList.text += "* " + str(task) + "\n"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
