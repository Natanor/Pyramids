extends Node2D
const BASE_BLOCK = preload("res://Prefabs/Blocks/BaseBlock.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
		
func _physics_process(delta):
	if Input.is_action_just_pressed("LMB"):
		var newblock = BASE_BLOCK.instantiate()
		add_child(newblock)
		newblock.global_position = get_global_mouse_position()
		
	
