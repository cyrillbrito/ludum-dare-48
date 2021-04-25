extends "res://Base/Entity.gd"

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


func _tick():
	pass
