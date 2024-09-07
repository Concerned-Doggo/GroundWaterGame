extends Area2D

const FILE_BEGINING = "res://Levels/level_" 

func _on_body_entered(body):
	if body.is_in_group("player"):
		var current_scene_path = get_tree().get_current_scene().scene_file_path
		var next_level = current_scene_path.to_int() + 1
		var next_level_path = FILE_BEGINING + str(next_level) + ".tscn"
		get_tree().change_scene_to_file(next_level_path)

