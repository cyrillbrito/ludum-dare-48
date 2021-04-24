extends KinematicBody2D

var bullet = preload("res://Bullet/Bullet.tscn")
var maxFireDelay = 0.25
var fireDelay = maxFireDelay
var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	set_process(true) 


func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		move_and_collide(Vector2(-speed * delta, 0))
	elif Input.is_action_pressed("ui_right"):
		move_and_collide(Vector2(speed * delta, 0))
	elif Input.is_action_pressed("ui_up"):
		move_and_collide(Vector2(0, -speed * delta))
	elif Input.is_action_pressed("ui_down"):
		move_and_collide(Vector2(0, speed * delta))
		


func _process(delta):
	if fireDelay < 0:
		if Input.is_action_pressed("fire") : #span Bullet
			print("Shoot")
			var bulletIntance = bullet.instance()
			bulletIntance.position = Vector2(position.x + 50 , position.y)
			get_tree().get_root().add_child(bulletIntance)
			fireDelay = maxFireDelay
	else:
		fireDelay -= delta
		
