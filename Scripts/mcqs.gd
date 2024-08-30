extends CanvasLayer

@onready var label = $Label
@onready var options_container = $Options
@onready var plank_label = $PlankLabel
@onready var option1_button = $Options/Option1
@onready var option2_button = $Options/Option2
@onready var option3_button = $Options/Option3

var current_dialog = 0

var dialog_texts = [
	{
		"question": "What is the main source of groundwater?",
		"options": ["Rainfall", "Rivers", "Lakes"],
		"answer": 0
	},
	{
		"question": "How can we recharge groundwater?",
		"options": ["Artificial recharge", "Deforestation", "Urbanization"],
		"answer": 0
	},
	{
		"question": "What crop type requires less water?",
		"options": ["Wheat", "Rice", "Millets"],
		"answer": 2
	},
	{
		"question": "Which practice helps in conserving groundwater?",
		"options": ["Over-irrigation", "Mulching", "Water Logging"],
		"answer": 1
	}
]

var plank_texts = [
	"Groundwater levels have been decreasing due to excessive use of tubewells.",
	"Microirrigation systems help in saving a significant amount of water.",
	"Rainwater harvesting is an effective way to recharge groundwater.",
	"Contamination of groundwater can lead to serious health issues."
]

func _ready() -> void:
	type(dialog_texts[current_dialog]["question"],1)

func type(text, isquestion):
	options_container.hide()  # Hide options at the start
	label.visible_ratio = 0
	label.text = text
	label.add_theme_font_size_override("font_size", 24)
	var tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1, 1)
	if isquestion:
		tween.tween_callback(show_options)
		
func show_options():
	options_container.show()  # Make sure the options are shown
	option1_button.text = dialog_texts[current_dialog]["options"][0]
	option2_button.text = dialog_texts[current_dialog]["options"][1]
	option3_button.text = dialog_texts[current_dialog]["options"][2]


func check_answer(selected_option):
	print(selected_option)
	if selected_option == dialog_texts[current_dialog]["answer"]:
		type("Correct! " + dialog_texts[current_dialog]["options"][selected_option] + " is the right answer.", 0)
	else:
		type("Incorrect! The correct answer is " + dialog_texts[current_dialog]["options"][dialog_texts[current_dialog]["answer"]], 0)
	
	options_container.hide()
	current_dialog += 1
	
	if current_dialog < dialog_texts.size():
		await get_tree().create_timer(2).timeout
		type(dialog_texts[current_dialog]["question"], 1)
	else:
		await get_tree().create_timer(2).timeout
		type("You've completed the quiz!", 0)

# Plank Card Interaction Function
func show_plank_info(plank_index):
	plank_label.visible = true
	plank_label.text = plank_texts[plank_index]
	await get_tree().create_timer(3).timeout
	plank_label.visible = false

# Example usage of plank card interaction:
# show_plank_info(0)  # Call this when player interacts with the first plank card


func _on_option_1_pressed() -> void:
	check_answer(0)


func _on_option_2_pressed() -> void:
	check_answer(1)


func _on_option_3_pressed() -> void:
	check_answer(2)
