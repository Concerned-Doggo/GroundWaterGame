extends Area2D


class_name Enemy

@export var horizontal_speed = 30
@export var vertical_speed = 100

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D as RayCast2D

@onready var rayCastRight: RayCast2D = $RightRayCast as RayCast2D
@onready var rayCastLeft: RayCast2D = $LeftRayCast as RayCast2D

var direction = 1
var SPEED = 30

func _process(delta: float) -> void:
	if !ray_cast_2d.is_colliding():
		position.y += delta * vertical_speed
	
	if rayCastRight.is_colliding():
		direction = -1
		$AnimatedSprite2D.flip_h = true;
	if rayCastLeft.is_colliding():
		direction = 1
		$AnimatedSprite2D.flip_h = false
	position.x += direction * SPEED * delta
	
	
		
	

func die():
	horizontal_speed = 0
	vertical_speed = 0
	animated_sprite_2d.play("death")
	queue_free()
