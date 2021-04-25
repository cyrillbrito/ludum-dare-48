extends "res://Base/Enemy.gd"

const bullet = preload("res://Bullet/Bullet.tscn")

# used in the attack logic
var bulletTimeout
var bulletCurrent


func _ready():
	life = 5
	killScore = 700
	attackInterval = 0.9


func _process(delta):

	if death:
		return
	
	if bulletCurrent != null:
		bulletTimeout -= delta
		bulletLogic()


func _physics_process(delta):
	pass


func _die():
	animation_death()


func _damage():
	$AnimationPlayer.play("damage")
	

func _attack():
	if(rng.randf() < .3):
		init_bullet(PI)
	else:
		animation_attack()
		bulletCurrent = 7
		bulletTimeout = 0.5
		attackTimeout += 1.2


func bulletLogic():
	if 0 < bulletTimeout:
		return
	
	init_bullet(PI/4 * bulletCurrent - PI/2)
	if(bulletCurrent == 0):
		bulletCurrent = null
	else:
		bulletCurrent -= 1
		bulletTimeout += 0.05



func init_bullet(degrees):
	var bulletinstance = bullet.instance()
	bulletinstance.z_index = -10
	bulletinstance.position = position
	bulletinstance.degrees = degrees
	bulletinstance.type = EntityTypes.MOB_BULLET
	bulletinstance.get_node("SpritePlayer").queue_free()
	get_parent().add_child(bulletinstance)


# =========== ANIMATION FUNCTIONS ===========
func animation_idel():   $AnimationTree.get("parameters/playback").travel("idle")
func animation_attack(): $AnimationTree.get("parameters/playback").travel("attack")
func animation_death(): $AnimationTree.get("parameters/playback").travel("death")
func animation_is_attacking(): return $AnimationTree.get("parameters/playback").get_current_node() == "attack"
