extends RigidBody2D

var player: Node2D
var level: Node2D
var isHeld: bool


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	level = get_tree().get_nodes_in_group("Level")[0]
	freeze = true
	#player = find_node("Player")
	if player != null:
		print_debug("player found")
	isHeld = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isHeld:
		position.x = player.position.x
		position.y = player.position.y + 20
		if Input.is_action_just_pressed("Drop"):
			isHeld = false
			freeze = false
			level._standbyNewBlock()
		
	if position.y > level.getKillHeight() and not freeze: # this is very finiky without a collider instead, but it sorta works
		($Sprite2D as Sprite2D).modulate = Color(0.662745, 0.662745, 0.662745, 1)
		freeze = true
		
		level.lives -= 1;
		
