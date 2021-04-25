extends KinematicBody2D

var speed = 300
export var hasLife = false
export var isPlayer = false
export var degrees = PI


func _ready():
	pass


func _physics_process(delta):
	if isPlayer :
		var collidedObjext =  move_and_collide(Vector2(speed * delta, 0))
		if collidedObjext:
			collidedObjext.collider.queue_free()
			queue_free()
	else:
		var x = cos(degrees) * speed * delta
		var y = sin(degrees) * speed * delta
		var collidedObjext =  move_and_collide(Vector2(x, y))
		if collidedObjext:
			var player = collidedObjext.collider
			queue_free()
			if player.hasLife:
				player.life -= 0.5
			else:
				player.queue_free()
