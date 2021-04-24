extends Node2D


var speed = 100


func _physics_process(delta):
	position = Vector2(position.x + speed * delta, position.y)
	
	
func _process(delta):
	$Life.text = str(get_node("Player").life) + "/" + str(get_node("Player").maxLife)

