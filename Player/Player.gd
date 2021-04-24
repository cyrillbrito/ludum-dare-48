extends KinematicBody2D

var bullet = preload("res://Bullet/Bullet.tscn")
var maxFireDelay = 0.4
var fireDelay = maxFireDelay
var speed = 300
export var hasLife = true
export var life = 10
export var maxLife = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	set_process(true)
	animation_start()


func _physics_process(delta):
	var velocity = Vector2()
	print("life  "+ str(life))
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
		animation_attack()
	else:
		animation_idel()

	if fireDelay < 0:
		if Input.is_action_pressed("fire"): #span Bullet
			var bulletIntance = bullet.instance()
			bulletIntance.isPlayer = true
			bulletIntance.collision_layer = 2^2
			
			bulletIntance.collision_mask = 8
			bulletIntance.position = Vector2(position.x + 50 , position.y - 30)
			get_parent().add_child(bulletIntance)
			fireDelay = maxFireDelay
	else:
		fireDelay -= delta


# =========== ANIMATION FUNCTIONS ===========
func animation_start():  $AnimationTree.get("parameters/playback").start("idle")
func animation_idel():   $AnimationTree.get("parameters/playback").travel("idle")
func animation_attack(): $AnimationTree.get("parameters/playback").travel("attack")
