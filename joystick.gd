extends Control
#GODOT 4.2
#NOTE: To use this template just copy the control.tscn/joystick.gd/Bigcircle.png/Center.png
#paste it in your folders ,connect the scripts and just drag and dropit to your player.tscn
#Check the sample of PLAYER.tscn and the script
#NOTE: This is primarily developed for android. You can use this for games that requires this types of controls such as 
#TPS,FPS,TOPDOWN,2DGAME.etc..if you want to continue this just delete the "andoid" folder and replace it on your own by Project>Install Android Build Template
#NOTE: If your want to replace the textures. Make sure it matches the dimension of BIG and CENTER
#for BIG Texturedimension : 128x128
#for CENTER Texture dimension : 32x32
#NOTE: SkillSets.the layout is bad ,Much better if we can customize their positions. that can be saved/Use in cloud. Its up to you how you will contruct it.

#I Know my code is not that good.still trying to improve it and share you my progress.

#BUG: When the first touch is on right then the second touch is left. the joystick disappear and wont work
#which is not good and inconvenient for the players. but doing it 


#Switches
@export var isStatic : bool = false #Refers about joystick position stays ons position static? or Move along dynamicslly?
@export var JoystickLocation : Vector2 = Vector2(70,230) #Refers about the joystick location
@export var LeftScreenDistanceLimit : float = 300 # X angle of the android screen in landscape mode from 0 to 300 <---->
@export var JoystickLimit :float = 50.0 #clamp limit 
@onready var JoyStickNode2d : Node2D =$JOYSTICKM
@onready var CENTER : Sprite2D = %CENTER
var Direction : Vector2
var inside : bool = true


func _ready() -> void:
	if isStatic == true:
		JoyStickNode2d.position = JoystickLocation
		JoyStickNode2d.visible = true
func _input(event: InputEvent) -> void:
	#Detecting screen touch in < 300 of the screen
	if isStatic == false:
		if event is InputEventScreenTouch and event.is_pressed():
			inside = true
			if event.position.x < LeftScreenDistanceLimit:
				JoyStickNode2d.position = event.position
				JoyStickNode2d.visible = true
		elif event is InputEventScreenTouch and event.is_released():
			
			if event.position.x < LeftScreenDistanceLimit:
				inside = false
				JoyStickNode2d.visible = false
				JoyStickNode2d.global_position = Vector2.ZERO
				CENTER.global_position = Vector2.ZERO
		#Detecting screendrag in < 300 of the screen
		if event is InputEventScreenDrag and inside == true:
			if event.position.x < LeftScreenDistanceLimit :
				CENTER.global_position = event.position
				#lintik na limiter
				CENTER.position = CENTER.position.limit_length(50.0) 
			if event.position.x > LeftScreenDistanceLimit and event.index == 0:
				inside = false
				JoyStickNode2d.visible = false
				JoyStickNode2d.global_position = Vector2.ZERO
				CENTER.global_position = Vector2.ZERO
	else:
		if event is InputEventScreenTouch and event.is_pressed():
			inside = true
			if event.position.x < LeftScreenDistanceLimit:
				CENTER.position = event.position
		elif event is InputEventScreenTouch and event.is_released():
			if event.position.x < LeftScreenDistanceLimit:
				inside = false
				CENTER.position = Vector2.ZERO
		if event is InputEventScreenDrag and inside == true:
			if event.position.x < LeftScreenDistanceLimit :
				CENTER.global_position = event.position
				#lintik na limiter
				CENTER.position = CENTER.position.limit_length(50.0) 
			if event.position.x > LeftScreenDistanceLimit and event.index == 0:
				inside = false
				CENTER.position = Vector2.ZERO
		pass
