extends "res://Base/Entity.gd"

const EntityTypes = preload("res://Base/enum.gd").EntityTypes
var bullet = preload("res://Bullet/Bullet.tscn")

var maxFireDelay = 0.4
var fireDelay = maxFireDelay
var speed = 300
export var hasLife = true
export var maxLife = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	type = EntityTypes.PLAYER
	life = 10


func _physics_process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	velocity = velocity.normalized() * speed * delta

	
	var overlaps = get_overlapping_areas()
	for overlap in overlaps:
		if overlap.type == EntityTypes.TOP_LIMIT:
			if velocity.y < 0:
				 velocity.y = 0
		elif overlap.type == EntityTypes.BOTTOM_LIMIT:
			if 0 < velocity.y:
				 velocity.y = 0
		elif overlap.type != EntityTypes.PLAYER_BULLET:
			life -= 1
			overlap.queue_free()
			
	position.x += velocity.x
	position.y += velocity.y


func _process(delta):
	
	if Input.is_action_pressed("fire"):
		animation_attack()
	else:
		animation_idel()

	if fireDelay < 0:
		if Input.is_action_pressed("fire"): #span Bullet
			var bulletIntance = bullet.instance()
			bulletIntance.type = EntityTypes.PLAYER_BULLET
			bulletIntance.degrees = 0
			bulletIntance.position = Vector2(position.x + 50 , position.y - 30)
			get_parent().add_child(bulletIntance)
			fireDelay = maxFireDelay
	else:
		fireDelay -= delta


# =========== ANIMATION FUNCTIONS ===========
func animation_idel():   $AnimationTree.get("parameters/playback").travel("idle")
func animation_attack(): $AnimationTree.get("parameters/playback").travel("attack")
