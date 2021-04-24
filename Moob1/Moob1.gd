extends KinematicBody2D

var bullet = preload("res://Bullet/Bullet.tscn")
var maxFireDelay = 0.25
var fireDelay = maxFireDelay
var life = 10

func _process(delta):
	if fireDelay < 0:
			print("Shoot", position)
			var bulletIntance = bullet.instance()
			bulletIntance.position = Vector2(position.x + 50 , position.y)
			get_parent().add_child(bulletIntance)
			fireDelay = maxFireDelay
	else:
		fireDelay -= delta
