extends "res://Base/Entity.gd"

const EntityTypes = preload("res://Base/enum.gd").EntityTypes

export var leftSpeed = 40
export var topDownSpeed = 20
export var changeSwitchDir = 0.3
export var killScore = 500
export var attackInterval = 1.2

var dir
var deltaSinceTick = 0
var rng = RandomNumberGenerator.new()

var death = false

var attackTimeout

func _ready():
	rng.randomize()
	dir = rng.randf() < 0.5
	attackTimeout = rng.randf_range(0, attackInterval)


func _physics_process(delta):
	
	if death:
		return

	if position.x < - 100:
		queue_free()
	
	# --- change dir
	deltaSinceTick += delta
	while (1 < deltaSinceTick):
		deltaSinceTick -= 1
		if rng.randf() < changeSwitchDir:
			dir = !dir
	
	# --- move
	position.x = position.x - leftSpeed * delta
	if dir:
		position.y += topDownSpeed * delta
	else:
		position.y -= topDownSpeed * delta
	
	# --- attack
	attackTimeout -= delta
	if attackTimeout < 0:
		attackTimeout += attackInterval
		_attack()
	
	# --- collisions
	var overlaps = get_overlapping_areas()
	for overlap in overlaps:
		if overlap.type == EntityTypes.TOP_LIMIT:
			dir = true
		elif overlap.type == EntityTypes.BOTTOM_LIMIT:
			dir = false
		elif overlap.type == EntityTypes.PLAYER_BULLET:
			overlap.queue_free()
			damage()
		elif overlap.type == EntityTypes.PLAYER:
			queue_free()


func damage():
	life -= 1
	_damage()
	if life <= 0:
		death = true
		get_parent().get_parent().get_node("Score").updateScore(killScore)
		_die()


func _die():
	pass

func _damage():
	pass


func _attack():
	pass
