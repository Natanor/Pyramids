extends Node2D
const BASE_BLOCK = preload("res://Prefabs/Blocks/BaseBlock.tscn")
const LONG_BLOCK = preload("res://Prefabs/Blocks/LongBlock.tscn")


var block_type_array: Array[Resource]
@export var block_holder: Node2D
@export var block_spawn_wait_time: float

var lives = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	_retrieveBlockTypes()
	_instantiateNewBlock()
	pass # Replace with function body.

func getKillHeight():
	#var camera =  get_viewport()
	#return camera.get_camera_2d().limit_bottom
	return 700

func _process(delta):
	pass
		
		

func _retrieveBlockTypes():
	block_type_array.append(BASE_BLOCK)
	block_type_array.append(LONG_BLOCK)
	print_debug(str(block_type_array))

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _instantiateNewBlock():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0, block_type_array.size() - 1)
	var newblock = block_type_array[num].instantiate()
	block_holder.add_child(newblock)
	
	pass
	
func _standbyNewBlock():
	await get_tree().create_timer(block_spawn_wait_time).timeout
	_instantiateNewBlock()
		

	
