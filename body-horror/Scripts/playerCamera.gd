extends Camera3D

@export var sensitivity = 0.002

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED # Locks mouse to center

func _input(event):
	# Toggle mouse mode with Escape
	if event.is_action_pressed("ui_cancel"): # "ui_cancel" is Escape by default
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if event is InputEventMouseMotion:
		# Rotate the player horizontally (Y-axis)
		get_parent().rotate_y(-event.relative.x * sensitivity)
		# Rotate the camera vertically (X-axis)
		rotation.x = clamp(rotation.x - event.relative.y * sensitivity, -1.5, 1.5)
