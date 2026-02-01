extends Control

#This button, when clicked, should load the main level
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")

#Get the options button synced to this function
func _on_option_button_pressed() -> void:
	pass # Replace with function body.
