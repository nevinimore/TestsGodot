extends CharacterBody2D

class_name Player

const SPEED = 300.0

func _physics_process(_delta):
	
	var dir := Vector2.ZERO
	dir.x = Input.get_axis("left", "right")
	dir.y = Input.get_axis("up", "down")
	
	if dir.x and dir.y:
		dir = dir.normalized()
		
		
	velocity = dir*SPEED
	
	move_and_slide()
