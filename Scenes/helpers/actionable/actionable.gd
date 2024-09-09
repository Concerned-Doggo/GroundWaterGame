extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
const Dict = {
	"Actionable:<Area2D#35836134889>" : "Lady",
	"Actionable:<Area2D#35618031071>" : "Farmer"
}

func action(characterNode: String) -> void:
	var CHARACTER = Dict[characterNode]
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogues/" + str(CHARACTER) + "Test1.dialogue"), "start")
