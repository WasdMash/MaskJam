extends Label

func _ready():
	# 'TaskManager' is the name you gave the Autoload in Project Settings
	TaskManager.register_task_label(self)
