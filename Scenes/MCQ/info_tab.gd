extends Area2D

@export var label : Label

func _ready():
	z_index = -1

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("gone")
		label.visible = true
		# var infoLabel = Label.new()
		label.add_theme_font_override("font", load("res://Assets/fonts/PixelOperator8.ttf")) 
		label.add_theme_font_size_override("font_size", 8) 
		#$Label.autowrap_mode = TextServer.AutowrapMode.AUTOWRAP_WORD


func _on_body_exited(body:Node2D):
	if body.is_in_group("player"):
		label.visible = false
