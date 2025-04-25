extends Node3D


var movetriger : int = 0
var movetriger2 : int = 0
var Velocity : Vector3 = Vector3.ZERO

const speed = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	pass # Replace with function body.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		$Camera3D.global_rotation_degrees.y -= event.relative.x * 0.12
		$Camera3D.global_rotation_degrees.x -= event.relative.y * 0.12
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Velocity += Vector3(Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left"),0,Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up"))
	
	
	global_position = Velocity * delta
	
	
	
	
	pass
