extends "res://Base/Enemy.gd"

const bullet = preload("res://Bullet/Bullet.tscn")

var hasLife = true

# used in the attack logic
var bulletTimeout
var bulletCurrent


func _ready():
	life = 4


func _process(delta):
	if position.x < -100:
		queue_free()
		
	if death:
		return
	
	if bulletCurrent != null:
		print(bulletTimeout)
		bulletTimeout -= delta
		bulletLogic()


func _physics_process(delta):
	pass


func _tick():
	if !animation_is_attacking() && rng.randf() < 0.4:
		animation_attack()
		bulletCurrent = 7
		bulletTimeout = 0.5


func _die():
	animation_death()


func bulletLogic():
	if 0 < bulletTimeout:
		return
	
	init_bullet(PI/4 * (bulletCurrent + 0.5) - PI/2)
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
