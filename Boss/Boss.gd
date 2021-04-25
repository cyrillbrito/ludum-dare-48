extends "res://Base/Enemy.gd"


const MobRedCell = preload("res://MobRedCell/MobRedCell.tscn")
const MobWhiteCell = preload("res://MobWhiteCell/MobWhiteCell.tscn")


func _ready():
	topDownSpeed = 5
	leftSpeed = 0
	life = 20
	$Timer1.connect("timeout",self,"_on_timer_timeout") 
	$Timer2.connect("timeout",self,"_on_timer_timeout") 
	$Timer3.connect("timeout",self,"_on_timer_timeout")
	spawnRound()


func _process(delta):
	pass

func _attack():
#	var bulletinstance = bullet.instance()
#	bulletinstance.position = position
#	bulletinstance.type = EntityTypes.MOB_BULLET
#	bulletinstance.get_node("SpritePlayer").queue_free()
#	get_parent().add_child(bulletinstance)
	pass


func spawnRound():
	$Timer1.start()
	$Timer2.start()
	$Timer3.start()


func _on_timer_timeout():
	print("timeout" + name)
	if rng.randf() < 0.3:
		spawnWhite()
	else:
		spawnRed()

func spawnRed():
	var instance = MobRedCell.instance()
	instance.position = Vector2(position.x - 50, position.y) 
	get_parent().add_child(instance)

func spawnWhite():
	var instance = MobWhiteCell.instance()
	instance.position = Vector2(position.x - 50, position.y) 
	get_parent().add_child(instance)


# =========== ANIMATION FUNCTIONS ===========
func animation_idle(): $AnimationTree.get("parameters/playback").travel("idle")
func animation_spawn(): $AnimationTree.get("parameters/playback").travel("spawn")
func animation_tired(): $AnimationTree.get("parameters/playback").travel("tired")
