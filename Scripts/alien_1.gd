extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	talk(8, 0.26)
	await get_tree().create_timer(3).timeout
	talk(18, 0.16)
	await get_tree().create_timer(3).timeout
	talk(4, 0.8)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func talk(amount, speed):
	var sprite = $Sprite2D as Sprite2D
	for i in range(amount):
		await get_tree().create_timer(speed).timeout
		sprite.frame = (sprite.frame + 1) % (sprite.vframes * sprite.hframes)
	
