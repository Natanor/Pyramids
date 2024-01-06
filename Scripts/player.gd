extends Node2D

@export var moveSpeed: float
@export var leftLimit: NodePath
@export var rightLimit: NodePath
@export var movementRotation: float
var minXPos: float
var maxXPos: float


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#figure out how to make this save without calling every frame
	var minXPos = get_node(leftLimit).global_position.x
	var maxXPos = get_node(rightLimit).global_position.x
	
	
	if Input.is_action_pressed("MoveLeft"): 
		global_position.x -= (moveSpeed * delta)
		rotation_degrees = -movementRotation
		if (global_position.x < minXPos):
			global_position.x = minXPos
	else: if Input.is_action_pressed("MoveRight"): 
		global_position.x += (moveSpeed * delta)
		rotation_degrees = movementRotation
		if (global_position.x > maxXPos):
			global_position.x = maxXPos
	else:
		#print_debug(str("not moving"))
		rotation_degrees = 0
		
	#print_debug(str(rotation))
	#print_debug(str(minXPos) + ", " + str(maxXPos) + ", " + str(position) + ", " + str(global_position))
	pass
