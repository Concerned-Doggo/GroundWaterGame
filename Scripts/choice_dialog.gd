extends CanvasLayer

@onready var label = $Label

func type(text):
	$Options.hide()
	label.visible_ratio = 0
	label.text = text
	label.add_theme_font_size_override("font_size", 24)
	var tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1, 1)
	if "quest" in text:
		tween.tween_callback(show_options)
		
func show_options():
	$Options.show()
	


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type("quest") 


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


func _on_yes_pressed() -> void:
	type("Great! Lets get started")
	$Options.hide()

func _on_no_pressed() -> void:
	type("Nice")
	$Options.hide()
