extends "res://Base/Enemy.gd"

const bullet = preload("res://Bullet/Bullet.tscn")

var maxFireDelay = 1
var fireDelay = maxFireDelay
export var hasLife = true


func _ready():
	topDownSpeed = 50
	changeSwitchDir = 0.5
	fireDelay = rng.randi_range(0, maxFireDelay)


func _process(delta):
	if fireDelay < 0:
			var bulletIntance = bullet.instance()
			bulletIntance.position = Vector2(position.x - 50 , position.y)
			bulletIntance.type = EntityTypes.MOB_BULLET
			bulletIntance.get_node("SpritePlayer").queue_free()
			get_parent().add_child(bulletIntance)
			fireDelay = maxFireDelay
	else:
		fireDelay -= delta

func _physics_process(delta):
	pass


func _die():
	animation_death()


# =========== ANIMATION FUNCTIONS ===========
func animation_death(): $AnimationTree.get("parameters/playback").travel("death")
