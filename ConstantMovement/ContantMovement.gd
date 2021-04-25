extends Node2D


const rounds = [
	preload("res://Rounds/Round0.tscn"),
	preload("res://Rounds/Round1.tscn"),
	preload("res://Rounds/Round2.tscn"),
	preload("res://Rounds/Round3.tscn"),
	preload("res://Rounds/Round4.tscn"),
]

enum State {
	STARTING,
	IN_GAME,
}

var speed = 100

var state = State.STARTING
var scene
var nextRound = 0

func _physics_process(delta):
	position = Vector2(position.x + speed * delta, position.y)
	
	
func _process(delta):
	$Life.text = str(get_node("Player").life) + "/" + str(get_node("Player").maxLife)
	
	if state == State.STARTING:
		if Input.is_action_pressed("fire"):
			loadRound()
	else: 
		print(scene.get_child_count())
		if scene.get_child_count() == 0:
			loadRound()
	

func loadRound():
	state = State.IN_GAME
	if scene != null:
		scene.queue_free()
	scene = rounds[nextRound].instance()
#	preload("res://Rounds/Round4.tscn").instance().get_child_count()
	add_child(scene)
	get_node("MainInterface").hide()
	nextRound += 1
