extends CharacterBody2D

@onready var animated_sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SPEED = 300.0
const JUMP_FORCE = 300.0


func _physics_process(delta: float) -> void:
	move(-1, 40)
	
	if is_on_floor():
		if is_on_wall():
			jump()
	else:
		velocity += get_gravity()*delta
	
	update_animation()


	move_and_slide()


func move(dir:int, speed:float):
	velocity.x = dir*speed
	animated_sprite.flip_h = true if dir>0 else false


func jump():
	if is_on_floor():
		velocity += Vector2.UP * JUMP_FORCE




func update_animation():
	if !is_on_floor():
		animated_sprite.play("jump")
	else:
		if absf(velocity.x)>0:
			animated_sprite.play("walk")
		else:
			animated_sprite.play("idle")
	pass
	