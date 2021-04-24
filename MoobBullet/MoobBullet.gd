extends KinematicBody2D

var speed = 400
export var damage = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
#	pass 
	# Replace with function body.

func _physics_process(delta):
	var collidedObjext =  move_and_collide(Vector2(-speed * delta, 0))
	if collidedObjext:
		print("I collided with ", collidedObjext.collider.life)
		var collided =  collidedObjext.collider 
		collided.life -= damage
#		print(str(collidedObjext))
		queue_free()
	
