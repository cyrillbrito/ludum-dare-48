extends KinematicBody2D

var speed = 300
export var hasLife = false
export var isPlayer = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)


func _physics_process(delta):
	if isPlayer :
		var collidedObjext =  move_and_collide(Vector2(speed * delta, 0))
		if collidedObjext:
			collidedObjext.collider.queue_free()
			queue_free()
	else:
		var collidedObjext =  move_and_collide(Vector2(-speed * delta, 0))
		if collidedObjext:
			var player = collidedObjext.collider
			queue_free()
			if player.hasLife:
				player.life -= 0.5
			else:
				player.queue_free()
