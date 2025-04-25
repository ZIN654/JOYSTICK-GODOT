extends CharacterBody3D

#TO FIX: Rotation of the YourChaeracter When the direction is changes

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var rotcamera
func _ready() -> void:
	pass
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED #  For FPS purpose

func _input(event: InputEvent) -> void:
	#Camera rotation input 
	if event is InputEventScreenDrag:
		if event.position.x > 300:
			$Node3D.global_rotation_degrees.y -= event.relative.x * 0.12
			rotcamera -= event.relative.x * 0.12

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	#==========================================JUST FOCUS ON THIS PART ========================================
	#WHEN USING THE CONTROL JUST DO THIS,Step1: access the Control.tscn 
	#step 2 : get the 2 object BIG/CENTER
	#Step 3 : Code some calculations (calculation code below)
	# EXPLANATION DYNAMIC JOYSTICK:Simply put we want the Direction from A:BIG to B:CENTER so to do that we minus the position of BIG with value Vec2(0,0) and the CENTER where our input comes in. then when touched or dragged,
	#the joystick:Center and the BIG relocates itself along with the Center,Center follows our touch/drag 
	var Direction = $Control/HBoxContainer/JOYSTICK/JOYSTICKM/BIG.position - $Control/HBoxContainer/JOYSTICK/JOYSTICKM/BIG/CENTER.position * delta
	var input_dir = -Direction.normalized()* 100 * delta 
	#the input_dir gives the normalized version of the Direction variable 
	

	#=========================================================================================
	$".".quaternion = Quaternion(Vector3.UP,rotcamera)
	if Direction != Vector2.ZERO: # for the Charater rotation
		$ANIMATEDCHAR/YourCharacter.rotation.y = lerp_angle($ANIMATEDCHAR/YourCharacter.rotation.y, atan2(Direction.x,Direction.y),0.1)
	#var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()  * Basis(Vector3.UP,$Node3D.global_rotation.y)
	#When camera is rotated it rotates the Forward Vector Movement DIrection
	var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()#.rotated(Vector3.UP,$Node3D.global_rotation.y)
	#$".".quaternion = Quaternion(direction,$Node3D.rotation_degrees.y * 0.012)
	#self.transform.basis = Basis(Vector3.UP,$Node3D.global_rotation.y) * transform.basis
	#this direction gives the rotated version of the forward Vector
	
	#do not use global rotation degree instead use the globalrotation it fucks up.
	#only use the global rotation degrees for assigning
	#:= (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()#.rotated(Vector3.UP,$Camera3D.global_rotation.y)
	#transform.basis 
	
	
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
