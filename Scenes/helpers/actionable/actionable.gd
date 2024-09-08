extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func action() -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/FarmerTest1.dialogue"), "start")
