extends KinematicBody2D

var bullet = preload("res://Bullet/Bullet.tscn")
var maxFireDelay = 0.25
var fireDelay = maxFireDelay
var speed = 300
export var life = 10
export var maxLife = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	set_process(true)


func _physics_process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	velocity = velocity.normalized() * speed * delta
	velocity = move_and_collide(velocity)

func _process(delta):
	if Input.is_action_pressed("fire"):
		$AnimationTree.set("parameters/transition/current", 1)
	else:
		$AnimationTree.set("parameters/transition/current", 0)
		
	
	if fireDelay < 0:
		if Input.is_action_pressed("fire"): #span Bullet
			var bulletIntance = bullet.instance()
			bulletIntance.isPlayer = true
			bulletIntance.collision_layer = 2
			bulletIntance.position = Vector2(position.x + 50 , position.y)
			get_parent().add_child(bulletIntance)
			fireDelay = maxFireDelay
	else:
		fireDelay -= delta
