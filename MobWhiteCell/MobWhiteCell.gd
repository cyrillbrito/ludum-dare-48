extends KinematicBody2D

var bullet = preload("res://Bullet/Bullet.tscn")
var maxFireDelay = 1
var fireDelay = maxFireDelay
var life = 10

var rng = RandomNumberGenerator.new()

var goingUp
export var leftSpeed = 40
export var topDownSpeed = 20

var deltaSinzeLastRand = 0;

func _ready():
	rng.randomize()
	goingUp = rng.randf() < 0.5
	fireDelay = rng.randi_range(0, maxFireDelay)


func _process(delta):
	if fireDelay < 0:
			var bulletIntance = bullet.instance()
			bulletIntance.position = Vector2(position.x - 50 , position.y)
			bulletIntance.collision_layer = 1
			get_parent().add_child(bulletIntance)
			fireDelay = maxFireDelay
	else:
		fireDelay -= delta

func _physics_process(delta):
	
	deltaSinzeLastRand += delta
	while(deltaSinzeLastRand > 1):
		deltaSinzeLastRand -= 1
		if rng.randf() < 0.1:
			goingUp = !goingUp
	
	var y
	if goingUp:
		y = position.y - topDownSpeed * delta
	else:
		y = position.y + topDownSpeed * delta
		
	position = Vector2(position.x + -leftSpeed * delta, y)
