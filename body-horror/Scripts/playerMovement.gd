extends CharacterBody3D

const SPEED = 5.0
const TURNING_CONSTANT = 0.1

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
		#Has to be in the order of left, right, up and down
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#Lowkey don't fully know why my cameraController rotation is off by 90 degrees but i don't really care
	# 1. Get the camera's forward and right vectors, but ignore the Y (vertical) component
	var cam_forward = -$cameraController/camera_target/Camera3D.global_transform.basis.z
	var cam_right = $cameraController/camera_target/Camera3D.global_transform.basis.x
	# 2. Flatten them so we don't move up/down
	cam_forward.y = 0
	cam_right.y = 0
	cam_forward = cam_forward.normalized()
	cam_right = cam_right.normalized()
	
	# 3. Calculate movement relative to those flattened vectors
	var direction = (cam_forward * -input_dir.y + cam_right * input_dir.x).normalized()
	if input_dir != Vector2(0,0):
		$MeshInstance3D.rotation_degrees.y = $cameraController.rotation.y - 90 - rad_to_deg(input_dir.angle())
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	#Camera movement time - apparently less buggy when after physics
	$cameraController.position = lerp($cameraController.position, position, delta * 5)
