extends Node2D

export var score = 0

func _process(delta):
	$Label.text = "Score: " + str(score)
	
func updateScore(value):
	score += value;
	if score < 0:
		score = 0
