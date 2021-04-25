extends "res://Base/Enemy.gd"

const bullet = preload("res://Bullet/Bullet.tscn")

var hasLife = true

var bulletsIn

func _ready():
	life = 4


func _process(delta):
	if bulletsIn != null:
		bulletsIn -= delta
		if(bulletsIn < 0):
			init_bullets()
			bulletsIn = null


func _physics_process(delta):
	pass


func _tick():
	if !animation_is_attacking() && rng.randf() < 0.4:
		animation_attack()
		bulletsIn = 0.7


func init_bullets():
	init_bullet(PI/3*0)
	init_bullet(PI/3*1)
	init_bullet(PI/3*2)
	init_bullet(PI/3*3)
	init_bullet(PI/3*4)
	init_bullet(PI/3*5)


func init_bullet(degrees):
	var instance = bullet.instance()
	var x = position.x + cos(degrees) * 10
	var y = position.y + sin(degrees) * 10
	instance.position = Vector2(x, y)
	instance.degrees = degrees
	instance.type = EntityTypes.MOB_BULLET
	get_parent().add_child(instance)


# =========== ANIMATION FUNCTIONS ===========
func animation_idel():   $AnimationTree.get("parameters/playback").travel("idle")
func animation_attack(): $AnimationTree.get("parameters/playback").travel("attack")
func animation_is_attacking(): return $AnimationTree.get("parameters/playback").get_current_node() == "attack"
