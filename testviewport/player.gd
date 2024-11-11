extends CharacterBody2D

class_name Player

const SPEED := 100.0
const JUMP_VELOCITY := 200.0
const gravity:float = 500 

@onready var animation:AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction:= Input.get_axis("move_left", "move_right")
	if direction:
		animation.play("walk")
		animation.flip_h = false if direction>0 else true
		velocity.x = move_toward(velocity.x, direction * SPEED, (SPEED/2)*delta)
	else:
		animation.play("idle")
		velocity.x = move_toward(velocity.x, 0, (SPEED*2)*delta)

	move_and_slide()
