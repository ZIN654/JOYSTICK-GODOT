extends MeshInstance3D

var value : float = 0
var dir : Vector3
var Speed : float = 0.02
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		value = event.relative.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# basis(Axis,angle) only represents the rotation

	#transform.basis = transform.basis.rotated(Vector3.UP,value * 0.23)
	#other approaches
	#
	transform.basis =  Basis(Vector3.UP,value * 0.032) * transform.basis
	
	#why we multiply it into its original basis?
	print(transform.basis)
	transform.origin += Speed * (transform.basis * Vector3(Input.get_action_strength("ui_up")- Input.get_action_strength("ui_down"),0, Input.get_action_strength("ui_left")- Input.get_action_strength("ui_right")).normalized())
	# if i 
	value = 0
	
	pass
