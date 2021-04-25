extends Control

var finalScore = 0

func _ready():
	$ScoreNumber.text = str(finalScore)
