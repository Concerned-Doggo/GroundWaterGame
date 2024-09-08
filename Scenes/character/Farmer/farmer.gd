extends CharacterBody2D



const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var rayCastLeft = $RayCast/LeftRayCast
@onready var rayCastRight = $RayCast/RightRayCast

const SPEED = 60
var direction = 1
var prevDirection = -1

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if rayCastRight.is_colliding():
		direction = -1
		prevDirection = 1
		$AnimatedSprite2D.flip_h = true;
		
	if rayCastLeft.is_colliding():
		direction = 1
		prevDirection = -1
		$AnimatedSprite2D.flip_h = false
	
	position.x += direction * SPEED * delta
	
	

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		print("ok")
		$AnimatedSprite2D.play("idle")
		direction = 0
	else:
		$Area2D/CollisionShape2D.position.x *= -1
	



func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		$AnimatedSprite2D.play("walk")
		if prevDirection == 1:
			direction = -1
		else:
			direction = 1
