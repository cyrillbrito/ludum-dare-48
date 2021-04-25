extends "res://Base/Enemy.gd"

const bullet = preload("res://Bullet/Bullet.tscn")


func _ready():
	topDownSpeed = 50
	changeSwitchDir = 0.5


func _process(delta):
	pass


func _physics_process(delta):
	pass


func _die(): 
	animation_death()


func _attack():
	var bulletinstance = bullet.instance()
	bulletinstance.position = position
	bulletinstance.type = EntityTypes.MOB_BULLET
	bulletinstance.get_node("SpritePlayer").queue_free()
	get_parent().add_child(bulletinstance)


# =========== ANIMATION FUNCTIONS ===========
func animation_death(): $AnimationTree.get("parameters/playback").travel("death")
