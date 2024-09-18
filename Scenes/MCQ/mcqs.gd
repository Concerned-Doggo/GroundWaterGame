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
		"question": "Which of the following is a major advantage of micro-irrigation systems (like drip irrigation) during drought conditions?",
		"options": ["It reduces water usage by up to 50%", "It eliminates the need for groundwater extraction", "It increases crop yield by using untreated wastewater"],
		"answer": 0
	},
	{
		"question": "How does crop diversification help in managing water resources during drought conditions?",
		"options": ["It increases groundwater recharge by modifying soil structure", "It reduces the overall demand for irrigation by switching to drought-resistant crops", "It decreases the need for fertilizers, which reduces water contamination"],
		"answer": 1
	},
	{
		"question": "Which of the following irrigation methods is least efficient for water conservation in drought-prone areas?",
		"options": ["Sprinkler irrigation", "Drip irrigation", "Surface irrigation"],
		"answer": 2
	},
	{
		"question": "Which of the following measures is the most effective for sustaining groundwater levels during prolonged droughts?",
		"options": ["Switching to high-water-use crops", "Increasing groundwater extraction during droughts", "Implementing rainwater harvesting and artificial recharge systems"],
		"answer": 2
	}
]

var plank_texts = [
	"It reduces water usage by up to 50% (Micro-irrigation delivers water directly to the roots, minimizing evaporation and runoff, which is critical during drought.)",
	"It reduces the overall demand for irrigation by switching to drought-resistant crops (Diversifying crops to include drought-resistant varieties can reduce water needs.)",
	"Surface irrigation (Surface irrigation often leads to significant water loss through evaporation and runoff, making it less efficient in conserving water.)",
	"Implementing rainwater harvesting and artificial recharge systems (These systems help capture available water during the rainy season and store it underground for use during droughts.)"
]


func _ready() -> void:
	type(dialog_texts[current_dialog]["question"], true)

func type(text: String, is_question: bool) -> void:
	
	options_container.hide()  # Hide options at the start
	label.visible_ratio = 0
	label.text = text
	label.add_theme_font_size_override("font_size", 24)
	var tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1, 1)
	if is_question:
		tween.tween_callback(Callable(self, "show_options"))

func show_options() -> void:
	label.text = ""
	options_container.show()  # Make sure the options are shown
	option1_button.text = dialog_texts[current_dialog]["options"][0]
	option2_button.text = dialog_texts[current_dialog]["options"][1]
	option3_button.text = dialog_texts[current_dialog]["options"][2]

func check_answer(selected_option: int) -> void:
	
	if selected_option == dialog_texts[current_dialog]["answer"]:
		type("Correct! " + dialog_texts[current_dialog]["options"][selected_option] + " is the right answer.", false)
	else:
		label.text = ""
		type("Incorrect! The correct answer is " + dialog_texts[current_dialog]["options"][dialog_texts[current_dialog]["answer"]], false)
	
	options_container.hide()
	current_dialog += 1
	
	if current_dialog < dialog_texts.size():
		await get_tree().create_timer(2).timeout
		type(dialog_texts[current_dialog]["question"], true)
	else:
		await get_tree().create_timer(2).timeout
		type("You've completed the quiz!", false)
		await get_tree().create_timer(2).timeout
		queue_free()

# Plank Card Interaction Function
func show_plank_info() -> void:
	# Display a random plank text after the quiz is completed
	
	var plank_index = randi() % plank_texts.size()
	plank_label.visible = true
	plank_label.text = plank_texts[plank_index]

	# Connect the plank_label to a mouse click event to hide it
	plank_label.connect("gui_input", Callable(self, "_on_plank_label_clicked"))

func _on_plank_label_clicked(event: InputEvent) -> void:
	# Check if the event is a left mouse button click
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		plank_label.visible = false
		plank_label.disconnect("gui_input", Callable(self, "_on_plank_label_clicked"))

func _on_option_1_pressed() -> void:
	check_answer(0)

func _on_option_2_pressed() -> void:
	check_answer(1)

func _on_option_3_pressed() -> void:
	check_answer(2)
