extends Node2D


var speed = 100

# Called when the node enters the scene tree for the first time.
#func _ready():
#	set_physics_process(true)



func _physics_process(delta):
	position = Vector2(position.x + speed * delta, position.y)
	
	
func _process(delta):
	$Life.text = str(get_node("Player").life) + "/" + str(get_node("Player").maxLife)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
