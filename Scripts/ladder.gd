extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ladder_body_entered(body: Node2D) -> void:
	if body.is_in_group("climber"):
		if body.climbing == false:
			body.climbing = true


func _on_ladder_body_exited(body: Node2D) -> void:
	if body.is_in_group("climber"):
		if body.climbing == true:
			body.climbing = false
