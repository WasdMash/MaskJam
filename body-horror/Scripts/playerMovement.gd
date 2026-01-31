extends CharacterBody3D

const SPEED = 5.0
const TURNING_CONSTANT = 0.1

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
		#Has to be in the order of left, right, up and down
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#Lowkey don't fully know why my cameraController rotation is off by 90 degrees but i don't really care
	if input_dir != Vector2(0,0):
		$MeshInstance3D.rotation_degrees.y = $cameraController.rotation.y - 90 - rad_to_deg(input_dir.angle())
	
	var direction = ($cameraController.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	#Camera movement time - apparently less buggy when after physics
	$cameraController.position = lerp($cameraController.position, position, delta * 5)
