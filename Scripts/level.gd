extends Node2D

const BASE_BLOCK = preload("res://Prefabs/Blocks/BaseBlock.tscn")
const LONG_BLOCK = preload("res://Prefabs/Blocks/LongBlock.tscn")
const SQUARE_BLOCK = preload("res://Prefabs/Blocks/SquareBlock.tscn")
const LINE_BLOCK = preload("res://Prefabs/Blocks/LineBlock.tscn")
const L_BLOCK = preload("res://Prefabs/Blocks/LBlock.tscn")
const REVERSEL_BLOCK = preload("res://Prefabs/Blocks/ReverseLBlock.tscn")
const ZIGZAG_BLOCK = preload("res://Prefabs/Blocks/ZigZagBlock.tscn")
const RZIGZAG_BLOCK = preload("res://Prefabs/Blocks/ReverseZigZagBlock.tscn")

var block_type_array: Array[Resource]
@export var block_holder: Node2D
@export var block_spawn_wait_time: float
@export var camera: Camera2D
@export var camera_offset = 250

var camera_min_height = 360
var blocks: Array[Node]

var height_in_metres: float

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
	_adjustCameraAndPlayer(_findHighestBlock())
	_getTowerHeightInMetres()
	pass
		
		

func _retrieveBlockTypes():
	block_type_array.append(BASE_BLOCK)
	block_type_array.append(LONG_BLOCK)
	block_type_array.append(SQUARE_BLOCK)
	block_type_array.append(LINE_BLOCK)
	block_type_array.append(L_BLOCK)
	block_type_array.append(REVERSEL_BLOCK)
	block_type_array.append(ZIGZAG_BLOCK)
	block_type_array.append(RZIGZAG_BLOCK)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _instantiateNewBlock():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0, block_type_array.size() - 1)
	var newblock = block_type_array[num].instantiate()
	block_holder.add_child(newblock)
	
	pass
	
func standbyNewBlock():
	await get_tree().create_timer(block_spawn_wait_time).timeout
	
	_instantiateNewBlock()
		
func loseLife():
	lives = lives -1
	if lives <= 0:
		_gameOver()
		pass

func _findHighestBlock():
	blocks = block_holder.get_children()
	var highestBlock = blocks[0]
	print_debug(str(blocks.size()))
	
	
	for i in range(blocks.size() - 1):
		if highestBlock.global_position.y > blocks[i].position.y:
			if !highestBlock.dropping:
				highestBlock = blocks[i]
			
	return highestBlock
	
	
func _getTowerHeightInMetres():
	if blocks.size() <= 1:
		return 0
	else:
		var highestBlock = _findHighestBlock()
		height_in_metres = (660 - highestBlock.position.y)/72
		
	print_debug(str(height_in_metres))

func _adjustCameraAndPlayer(highestBlock):
	if blocks.size() > 1:
		camera.offset.y = highestBlock.global_position.y - camera_offset
		if camera.offset.y > camera_min_height:
			camera.offset.y = camera_min_height
	
	$Player.position.y = camera.offset.y - 260
	
	
	#$Player.position.y = camera_offset
	

func _gameOver():
	print_debug("is dead")
	
