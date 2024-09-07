extends CharacterBody2D



const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var rayCastLeft = $RayCast/LeftRayCast
@onready var rayCastRight = $RayCast/RightRayCast

const SPEED = 60
var direction = 1

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if rayCastRight.is_colliding():
		direction = -1
		$AnimatedSprite2D.flip_h = true;
	if rayCastLeft.is_colliding():
		direction = 1
		$AnimatedSprite2D.flip_h = false
	
	position.x += direction * SPEED * delta
	
	

	move_and_slide()
