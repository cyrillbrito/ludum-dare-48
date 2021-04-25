extends Node2D


const rounds = [
	preload("res://Rounds/Round0.tscn"),
	preload("res://Rounds/Round1.tscn"),
#	preload("res://Rounds/Round2.tscn"),
#	preload("res://Rounds/Round3.tscn"),
#	preload("res://Rounds/Round4.tscn"),
]

const mainInterface = preload("res://Interfaces/Main.tscn")
const winInterface = preload("res://Interfaces/Win.tscn")
const lostInterface = preload("res://Interfaces/Lost.tscn")

enum State {
	STARTING,
	IN_GAME,
	END,
}

var speed = 100

var state
var scene
var nextRound
var player
var timeout = 0

func _ready():
	loadMainScene()
	player = get_node("Player")
	

func _physics_process(delta):
	position = Vector2(position.x + speed * delta, position.y)


func _process(delta):
	$Lifes.lifes = player.life
	if state == State.STARTING :
		timeout -= delta
		if Input.is_action_pressed("fire") && timeout < 0:
			loadNextRoundScene()
	elif state == State.IN_GAME:
		if scene.get_child_count() == 0:
			loadNextRoundScene()
		if player.life <= 0:
			loadLostScene()
	elif state == State.END:
		timeout -= delta
		if Input.is_action_pressed("fire") && timeout < 0:
			loadMainScene()


func loadNextRoundScene():
	state = State.IN_GAME
	scene.queue_free()
	if nextRound < rounds.size():
		scene = rounds[nextRound].instance()
		nextRound += 1
		if nextRound > 1:
			get_node("Score").updateScore(1000)
	else: 
		scene = winInterface.instance()
		state = State.END
		timeout = 2

	add_child(scene)


func loadLostScene():
	state = State.END
	timeout = 2
	scene.queue_free()
	scene = lostInterface.instance()
	add_child(scene)


func loadMainScene():
	state = State.STARTING
	# this only runs on the second playthrough
	if player != null:
		timeout = 1
		player.life = player.maxLife
	nextRound = 0
	if scene != null:
		scene.queue_free()
	scene = mainInterface.instance()
	add_child(scene)
