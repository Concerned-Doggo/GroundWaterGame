extends Node

@onready var scoreLabel = $"../Labels/Label3"

var score = 0

func add_point():
	score += 1
	scoreLabel.text = "Congratulations! You collected " + str(score) + " coins."
	print(score)
