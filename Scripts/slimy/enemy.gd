extends Area2D


class_name Enemy

@export var horizontal_speed = 30
@export var vertical_speed = 100

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D as RayCast2D


func _process(delta: float) -> void:
	position.x -= horizontal_speed * delta
	
	if !ray_cast_2d.is_colliding():
		position.y += delta * vertical_speed
		
	

func die():
	horizontal_speed = 0
	vertical_speed = 0
	animated_sprite_2d.play("death")
	
	queue_free()
