extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
#	pass 
	# Replace with function body.



func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		move_and_collide(Vector2(-speed * delta, 0))
	elif Input.is_action_pressed("ui_right"):
		move_and_collide(Vector2(speed * delta, 0))
	elif Input.is_action_pressed("ui_up"):
		move_and_collide(Vector2(0, -speed * delta))
	elif Input.is_action_pressed("ui_down"):
		move_and_collide(Vector2(0, speed * delta))

