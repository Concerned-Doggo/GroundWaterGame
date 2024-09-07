extends CharacterBody2D

@export var SPEED = 180.0
@export var JUMP_VELOCITY = -500.0
@export var GRAVITY = 1200.0

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	# Add gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		$AnimatedSprite2D.animation = "jump"
	else:
		velocity.y = 0  # Reset vertical velocity when on the floor

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle movement.
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED

	# Apply movement.
	move_and_slide()

	# Update animation based on movement direction.
	if direction != 0:
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		$AnimatedSprite2D.animation = "idle"
