extends "res://Base/Entity.gd"

const EntityTypes = preload("res://Base/enum.gd").EntityTypes

export var leftSpeed = 40
export var topDownSpeed = 20
export var changeSwitchDir = 0.3

var dir
var deltaSinceTick = 0
var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()
	dir = rng.randf() < 0.5


func _physics_process(delta):
	deltaSinceTick += delta
	while (1 < deltaSinceTick):
		deltaSinceTick -= 1
		_tick()
		if rng.randf() < changeSwitchDir:
			dir = !dir
	
	position.x = position.x - leftSpeed * delta
	if dir:
		position.y += topDownSpeed * delta
	else:
		position.y -= topDownSpeed * delta
		
	var overlaps = get_overlapping_areas()
	for overlap in overlaps:
		if overlap.type == EntityTypes.TOP_LIMIT || overlap.type == EntityTypes.BOTTOM_LIMIT:
			dir = !dir
		if overlap.type == EntityTypes.PLAYER_BULLET:
			overlap.queue_free()
			queue_free()
		if overlap.type == EntityTypes.PLAYER:
			queue_free()	

func _tick():
	pass
