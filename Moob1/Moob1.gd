extends KinematicBody2D

var bullet = preload("res://Bullet/Bullet.tscn")
var maxFireDelay = 1
var fireDelay = maxFireDelay
var life = 10

func _process(delta):
	if fireDelay < 0:
			var bulletIntance = bullet.instance()
			bulletIntance.position = Vector2(position.x - 50 , position.y)
			bulletIntance.collision_layer = 1
			get_parent().add_child(bulletIntance)
			fireDelay = maxFireDelay
	else:
		fireDelay -= delta
