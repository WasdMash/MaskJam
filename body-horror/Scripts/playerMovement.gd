extends CharacterBody3D

const SPEED = 5.0
const TURNING_CONSTANT = 0.1

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# 1. Get the camera's forward and right vectors, but ignore the Y (vertical) component
	var cam_forward = -$cameraController.global_transform.basis.z
	var cam_right = $cameraController.global_transform.basis.x
	
	# 2. Flatten them so we don't move up/down
	cam_forward.y = 0
	cam_right.y = 0
	cam_forward = cam_forward.normalized()
	cam_right = cam_right.normalized()
	
	# 3. Calculate movement relative to those flattened vectors
	var direction = (cam_forward * -input_dir.y + cam_right * input_dir.x).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		# 4. Smoothly rotate the mesh to face the movement direction
		var target_rotation = atan2(direction.x, direction.z)
		$MeshInstance3D.rotation.y = lerp_angle($MeshInstance3D.rotation.y, target_rotation, TURNING_CONSTANT)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	# Keep camera following
	$cameraController.position = lerp($cameraController.position, position, delta * 5)
