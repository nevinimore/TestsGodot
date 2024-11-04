extends Node2D

@onready var main_sprite: Sprite2D = $MainSprite
@onready var lerp_sprite: Sprite2D = $LerpSprite
@onready var lerp_sprite2: Sprite2D = $LerpSprite2
@onready var lerp_sprite3: Sprite2D = $LerpSprite3
@onready var move_sprite: Sprite2D = $MoveSprite


func _process(delta: float) -> void:

	print(delta)
	
	var rate_x3: float = 5
	var rate_y3: float = 5
	lerp_sprite3.position.x = lerp(lerp_sprite3.position.x, main_sprite.position.x, rate_x3*delta)
	lerp_sprite3.position.y = lerp(lerp_sprite3.position.y, main_sprite.position.y, rate_y3*delta)

	# depends on delta AND frame rate
	var rate_x2: float = 0.98
	var rate_y2: float = .7
	const FIXED_FRAME_RATE := 1.0
	lerp_sprite2.position.x = lerp(lerp_sprite2.position.x, main_sprite.position.x, 1 - pow(1 - rate_x2, delta*FIXED_FRAME_RATE))
	lerp_sprite2.position.y = lerp(lerp_sprite2.position.y, main_sprite.position.y, 1 - pow(1 - rate_y2, delta*FIXED_FRAME_RATE))

	# 500 for ~ 1 sec for half the way NOT DELTA DEPENDENT
	var rate_x: float = 8.0
	rate_x = pow(2, rate_x)
	var rate_y: float = 500.0
	lerp_sprite.position.x = lerp(lerp_sprite.position.x, main_sprite.position.x, pow(2, -rate_x*delta))
	lerp_sprite.position.y = lerp(lerp_sprite.position.y, main_sprite.position.y, pow(2, -rate_y*delta))

	move_sprite.position.x = move_toward(move_sprite.position.x, main_sprite.position.x, 100*delta)
	move_sprite.position.y = move_toward(move_sprite.position.y, main_sprite.position.y, 100*delta)


func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
#		print("Mouse Click/Unclick at: ", event.position)
		pass
	elif event is InputEventMouseMotion:
#		print("Mouse Motion at: ", event.position)
		pass
		
	# Print the size of the viewport.
#	print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)

	
	if Input.is_action_pressed("left_click"):
		main_sprite.position = event.position
#		print("draged: ", event.position)
