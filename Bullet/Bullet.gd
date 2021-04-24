extends KinematicBody2D

var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
#	pass 
	# Replace with function body.

func _physics_process(delta):
	 move_and_collide(Vector2(speed * delta, 0))
	
