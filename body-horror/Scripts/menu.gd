extends Control

#This button, when clicked, should load the main level
func _on_button_pressed() -> void:
	SoundManager.pause_background_music()
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")
