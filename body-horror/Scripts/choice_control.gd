extends Control

func _ready():
	# Listen for the manager to tell YOU to show choices
	GameManager.request_choices.connect(_on_show_requested)

func _on_choice_selected(id):
	# Tell the manager what happened
	GameManager.choice_made.emit(id)

# Godot calls this automatically when the signal is sent.
func _on_show_requested(options: Array):
	# This is where you write the code to actually show the buttons
	print("UI received these options from the manager: ", options)
	#I need a way of determing which of these choices is better than the other
	$Choice1.text = options[0]
	$Choice2.text = options[1]
