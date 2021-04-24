extends KinematicBody2D

var bullet = preload("res://MoobBullet/MoobBullet.tscn")
var maxFireDelay = 1
var fireDelay = maxFireDelay
var damage = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true) 


func _process(delta):
	if fireDelay < 0:
			print("Moob Shoot")
			var bulletIntance = bullet.instance()
			bulletIntance.position = Vector2(position.x - 50 , position.y)
			get_tree().get_root().add_child(bulletIntance)
			fireDelay = maxFireDelay
	else:
		fireDelay -= delta
		
