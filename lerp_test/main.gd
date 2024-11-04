extends Node2D

@onready var main_sprite: Sprite2D = $MainSprite
@onready var lerp_sprite: Sprite2D = $LerpSprite
@onready var lerp_sprite2: Sprite2D = $LerpSprite2
@onready var move_sprite: Sprite2D = $MoveSprite


func _physics_process(delta: float) -> void:


	var rate_x2: float = 0.98
	var rate_y2: float = .7
	lerp_sprite2.position.x = lerp(lerp_sprite2.position.x, main_sprite.position.x, 1 - pow(1 - rate_x2, delta * 1))
	lerp_sprite2.position.y = lerp(lerp_sprite2.position.y, main_sprite.position.y, 1 - pow(1 - rate_y2, delta * 1))
	
	# 500 for ~ 1 sec for half the way
	var rate_x: float = 8.0
	rate_x = pow(2, rate_x)
	var rate_y: float = 500.0
	lerp_sprite.position.x = lerp(lerp_sprite.position.x, main_sprite.position.x, pow(2, -rate_x*delta))
	lerp_sprite.position.y = lerp(lerp_sprite.position.y, main_sprite.position.y, pow(2, -rate_y*delta))

	move_sprite.position.x = move_toward(move_sprite.position.x, main_sprite.position.x, 10*delta)
	move_sprite.position.y = move_toward(move_sprite.position.y, main_sprite.position.y, 10*delta)


func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
	elif event is InputEventMouseMotion:
		print("Mouse Motion at: ", event.position)

	# Print the size of the viewport.
	print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)

	
	if Input.is_action_pressed("left_click"):
		main_sprite.position = event.position
		print("draged: ", event.position)
