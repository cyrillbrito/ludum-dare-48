extends "res://Base/Enemy.gd"

const EntityTypes = preload("res://Base/enum.gd").EntityTypes
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
#			bulletIntance.collision_layer = 8
#			bulletIntance.collision_mask=2^2
			bulletIntance.type = EntityTypes.MOB_BULLET
			get_parent().add_child(bulletIntance)
			fireDelay = maxFireDelay
	else:
		fireDelay -= delta

func _physics_process(delta):
	pass
