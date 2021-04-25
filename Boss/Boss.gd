extends "res://Base/Enemy.gd"


const MobRedCell = preload("res://MobRedCell/MobRedCell.tscn")
const MobWhiteCell = preload("res://MobWhiteCell/MobWhiteCell.tscn")

var tired = false
var spawning

func _ready():
	topDownSpeed = 5
	leftSpeed = 0
	life = 10
	$ProgressBar.value = life
	$ProgressBar.max_value = life
	killScore = 2000
	$Timer1.connect("timeout", self, "_on_timer_spawn") 
	$Timer2.connect("timeout", self, "_on_timer_spawn") 
	$Timer3.connect("timeout", self, "_on_timer_spawn")
	$TiredTimer.connect("timeout",self,"_on_timer_tired")
	$IdleTimer.connect("timeout",self,"_on_timer_idle")
	spawnRound()


func _process(delta):
	spawning -= delta
	if get_parent().get_child_count() == 1 && spawning < 0:
		if life < 0:
			get_parent().get_parent().loadNextRoundScene()
		else:
			spawnRound()


func spawnRound():
	$Timer1.start()
	$Timer2.start()
	$Timer3.start()
	spawning = $Timer3.wait_time


func _on_timer_spawn():
#	print(a)
	animation_spawn()
	if rng.randf() < 0.3:
		spawnWhite()
	else:
		spawnRed()


func spawnRed():
	var instance = MobRedCell.instance()
	instance.position = Vector2(position.x - 50, position.y) 
	instance.killScore = 250
	get_parent().add_child(instance)


func spawnWhite():
	var instance = MobWhiteCell.instance()
	instance.position = Vector2(position.x - 50, position.y)
	instance.killScore = 350
	get_parent().add_child(instance)


func _on_timer_tired():
	animation_tired()
	tired = true


func _on_timer_idle():
	animation_idle()
	tired = false
	


func _damage():
	if tired :
		$AnimationPlayer.play("damange")
		$ProgressBar.value = life
	else:
		life += 1


func _die():
	animation_tired()
	$ProgressBar.queue_free()


# =========== ANIMATION FUNCTIONS ===========
func animation_idle(): $AnimationTree.get("parameters/playback").travel("idle")
func animation_spawn(): $AnimationTree.get("parameters/playback").travel("spawn")
func animation_tired(): $AnimationTree.get("parameters/playback").travel("tired")
