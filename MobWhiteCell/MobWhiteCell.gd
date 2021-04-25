extends "res://Base/Enemy.gd"

var bullet = preload("res://Bullet/Bullet.tscn")
var maxFireDelay = 1
var fireDelay = maxFireDelay

var hasLife = true

func _ready():
	life = 10
	fireDelay = rng.randi_range(0, maxFireDelay)
	animation_start()


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
	pass


func _tick():
	if rng.randf() < 0.3:
		animation_attack()


# =========== ANIMATION FUNCTIONS ===========
func animation_start():  $AnimationTree.get("parameters/playback").start("idle")
func animation_idel():   $AnimationTree.get("parameters/playback").travel("idle")
func animation_attack(): $AnimationTree.get("parameters/playback").travel("attack")
