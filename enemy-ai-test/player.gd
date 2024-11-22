extends CharacterBody2D

class_name Player

@onready var animated_sprite:AnimatedSprite2D = $AnimatedSprite2D 

const SPEED = 300.0
const JUMP_VELOCITY = 300.0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= JUMP_VELOCITY

	var direction:= Input.get_axis("left", "right")
	if direction:
		if direction*velocity.x<0:
			move_toward(velocity.x, 0, SPEED*2*delta)
		velocity.x = lerpf(velocity.x, direction * SPEED, delta)
		velocity.x = move_toward(velocity.x, direction * SPEED, delta)
		velocity.x = clampf(velocity.x, -SPEED, SPEED)
		animated_sprite.flip_h = true if direction>0 else false
	else:
		velocity.x = move_toward(velocity.x, 0, (SPEED*2.1)*delta)
	
	update_animation()

	move_and_slide()

	
func update_animation():
	if !is_on_floor():
		animated_sprite.play("jump")
	else:
		if absf(velocity.x)>0:
			animated_sprite.play("walk")
		else:
			animated_sprite.play("idle")
	pass
	