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
var currentTask: Label
@export var tasksDoneToday := 0
@export var taskstoBeDoneDaily := 3

@export_group("Task completion stats")
@export var taskTime := 0.0 #This will be handled by delta so it should be a float
@export var taskStarted := false
@export var currentTaskName := ""
@export var currentMaxTaskTime := 0
var currentInsanityIndex := 0

@export_group("Insanities")
#Need to be able to track the insanity metres of each NPC
	#Emily. John , John Pork, Tyler and Naomi
#Basically, the higher their insanity, the wackier they will become
@export var insanities := [100.0,100.0,100.0,100.0,100.0] #Everyone starts kinda sane but you can make it worse
enum wellbeing{NORMAL,CREEP,WTF}
enum completion{NOT_DONE, IGNORED, DONE_WELL, DONE_POORLY}
#Lowkey ugly but we can make things better later
var tasks:= {"Fetch Emily water": completion.NOT_DONE,
			"Print the files": completion.NOT_DONE,
			"Check up on Naomi": completion.NOT_DONE,
			"Move the bin": completion.NOT_DONE,
			"Talk to John": completion.NOT_DONE,
			"Check over Tyler's work": completion.NOT_DONE,}
var dailyTasks := {} #Picking the daily tasks of the day to be completed

#The masks that we will set active and unactive depending on their insanities
@export_group("Checking the masks")
@export var creepMasks := []
@export  var WTFMasks := []
var foundMasks := false

func initialise_masks():
	#Getting all of my creep masks
	creepMasks = get_tree().get_nodes_in_group("creep")
	creepMasks.sort_custom(func(a, b): return a.get_index() < b.get_index())
	if len(creepMasks) > 0:
		foundMasks = true
	#Getting all of my WTF masks
	WTFMasks = get_tree().get_nodes_in_group("wtf")
	WTFMasks.sort_custom(func(a, b): return a.get_index() < b.get_index())
	
func switchMask(index : int):
	#This function should check the insanity of this mask and set its mask accordingly
	var insanity = insanities[index]
	if insanity < 0.33:
		#WTF time
		WTFMasks[index].show()
		creepMasks[index].hide()
	elif insanity < 0.66:
		#creep time
		creepMasks[index].show()
		WTFMasks[index].hide()
	else:
		#We are chilling rn, so let all of the masks go free
		creepMasks[index].hide()
		WTFMasks[index].hide()

func beginTask(taskName: String, taskMaxTime : float, insaneIndex:int) -> void:
	#only start tasks that haven't been done yet - no takebacks
	if dailyTasks.has(taskName):
		if dailyTasks[taskName] == completion.NOT_DONE:
			taskStarted = true
			currentTaskName = taskName
			currentMaxTaskTime = taskMaxTime
			currentTask.text = "Current task: " + currentTaskName
			currentInsanityIndex = insaneIndex
	
func completeTask():
	#Now we can complete said task
	#Calculate its insanity and then alter the insanity of the relevant character
	taskStarted = false #stop the timer
	var insanityCheck = taskTime / currentMaxTaskTime
	var taskCompletionType = completion.NOT_DONE
	insanities[currentInsanityIndex] *= (1 - insanityCheck) #The faster the tasks are done, the less insane they become
	if insanityCheck > 0.5:
		taskCompletionType = completion.DONE_WELL
	elif insanityCheck > 0.3:
		taskCompletionType = completion.DONE_POORLY
	#Should update the task list to accommodate this new change
	dailyTasks[currentTaskName] = taskCompletionType
	tasksDoneToday += 1
	#We automatically start a new day
	if tasksDoneToday == taskstoBeDoneDaily:
		GameManager.start_next_day_sequence()
	updateTasks()
	
func register_task_label(label_node: Label):
	taskList = label_node
	pick_daily_tasks()
	updateTasks() # Initial fill of the list

func pick_daily_tasks():
	dailyTasks.clear()
	var available_tasks = []
	for task in tasks:
		if tasks[task] == completion.NOT_DONE:
			available_tasks.append(task)	
	available_tasks.shuffle()
	var count = min(taskstoBeDoneDaily, available_tasks.size())
	for i in range(count):
		var task_name = available_tasks[i]
		dailyTasks[task_name] = completion.NOT_DONE
	
func register_current_task_label(label_node: Label):
	currentTask = label_node

#This is the function to be ran to update the task list
func updateTasks():
	#Need to pick TimeManager.tasksDoneDaily random tasks from our list
	taskList.text = ""
	for task in dailyTasks:
		var progress = dailyTasks[task]
		if progress == completion.NOT_DONE:
			taskList.text += "* " + str(task) + "\n"
			
	if currentTask != null:
		currentTask.text = "Completed task: " + currentTaskName
		currentTaskName = "" #We don't have a current taskName
		#Can have visual bugs if we enter a new zone in this time period
		await get_tree().create_timer(0.5).timeout
		currentTask.text = "Time to look for a new task to do"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#Should be slowly deteriorating the insanities of everyone in the office
	for i in range(len(insanities)):
		insanities[i] -= _delta
		if foundMasks: switchMask(i)
		else: initialise_masks()
