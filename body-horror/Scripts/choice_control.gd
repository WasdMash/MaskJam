extends Control
# Called when the node enters the scene tree for the first time.
func _ready():
	# Tell the global manager "I am the choice control"
	GameManager.choiceControl = self 
