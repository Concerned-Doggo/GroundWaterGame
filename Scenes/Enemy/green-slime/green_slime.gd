extends Node2D

const SPEED = 60
var direction = 1

@onready var rayCastRight = $RayCastRight
@onready var rayCastLeft = $RayCastLeft
@onready var animatedSprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rayCastRight.is_colliding():
		direction = -1
		animatedSprite.flip_h = true;
	if rayCastLeft.is_colliding():
		direction = 1
		animatedSprite.flip_h = false
	
	position.x += direction * SPEED * delta
