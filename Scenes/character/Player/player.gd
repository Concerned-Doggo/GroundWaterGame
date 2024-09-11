extends CharacterBody2D

@export var climbing = false

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@export_group("Enemy")
@export var min_stomp_deg = 35
@export var max_stomp_deg = 145

@export var stomp_y_velocity = -150


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animatedSprite = $AnimatedSprite2D
@onready var actionable_finder = $ActionableFinder

func _physics_process(delta):
	
	if climbing == false and not is_on_floor():
		velocity.y += gravity * delta
	elif climbing == true:
		velocity.y = 0
		if Input.is_action_pressed("ui_up"):
			velocity.y = -SPEED
		elif Input.is_action_pressed("ui_down"):
			velocity.y = SPEED
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if(direction > 0):
		animatedSprite.flip_h = false
	elif(direction < 0): 
		animatedSprite.flip_h = true
	
	
	# play animations
	
	if is_on_floor():
		if(direction == 0):
			animatedSprite.play("idle")
		else:
			animatedSprite.play("run")
	else:
		animatedSprite.play("jump")
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _input(event):
	if event.is_action_pressed("interact"):
		var actionables = actionable_finder.get_overlapping_areas()
		if(actionables.size() >= 1):
			actionables[1].action(str(actionables[1]))
			return

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Enemy:
		handle_enemy_collision(area)

func handle_enemy_collision(enemy: Enemy):
	print("1")
	if enemy == null:
		return
	print("2")
	print("posistion: ")
	print(position)
	print(enemy.position)
	var angle_of_collision = rad_to_deg(position.angle_to_point(enemy.position))
	print(angle_of_collision)
	if angle_of_collision > min_stomp_deg && max_stomp_deg > angle_of_collision:
		enemy.die()
		on_enemy_stomped()
	else:
		die()

func on_enemy_stomped():
	velocity.y = stomp_y_velocity


func die():
	Engine.time_scale = 0.5
	if $CollisionShape2D:
		$CollisionShape2D.queue_free()
	await get_tree().create_timer(0.5).timeout
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
