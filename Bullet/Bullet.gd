extends Area2D
const EntityTypes = preload("res://Base/enum.gd").EntityTypes

var speed = 400
export var hasLife = false
export var degrees = PI

var type
var damage = 1

func _ready():
	pass


func _physics_process(delta):

	if position.x < -10 || position.y < -10  || 1034 < position.x || 610 < position.y:
		queue_free()

	var x = cos(degrees) * speed * delta
	var y = sin(degrees) * speed * delta
	move(Vector2(x, y))

	if type != EntityTypes.PLAYER_BULLET:
		return

	var overlaps = get_overlapping_areas()
	for overlap in overlaps:
		if overlap.type == EntityTypes.MOB_BULLET:
			overlap.queue_free()
			queue_free()


func move(vector):
	position.x += vector.x
	position.y += vector.y
