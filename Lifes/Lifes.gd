extends Node2D

export var lifes = 5
const heart = preload("res://Lifes/Heart.tscn")


func _process(delta):
	var x = 50
	var y = 20
	print(get_child_count())
	var nChildsToCreate = lifes - get_child_count() ;
	if nChildsToCreate > 0:
		for i in range(nChildsToCreate):
			var heartIntance = heart.instance()
			heartIntance.position = Vector2(x, y)
			add_child(heartIntance)
			x += 40
	elif 0 > nChildsToCreate :
		for i in range(abs(nChildsToCreate)):
			get_child(get_child_count()-1).queue_free()
			x -= 40



