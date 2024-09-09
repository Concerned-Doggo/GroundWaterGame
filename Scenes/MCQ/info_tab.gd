extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

@onready var label = $Label


func _on_body_entered(body):
	if body.is_in_group("player"):
		# var infoLabel = Label.new()
		label.add_theme_font_override("font", load("res://Assets/fonts/PixelOperator8.ttf")) 
		label.add_theme_font_size_override("font_size", 8) 
		#$Label.autowrap_mode = TextServer.AutowrapMode.AUTOWRAP_WORD


# func _on_body_exited(body:Node2D):
# 	if body.is_in_group("player") :
# 		print("gone")
