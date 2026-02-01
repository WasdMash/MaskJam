extends Label

func _ready():
	# 'TaskManager' is the name you gave the Autoload in Project Settings
	TaskManager.register_current_task_label(self)
