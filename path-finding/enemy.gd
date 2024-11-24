extends CharacterBody2D

class_name Enemy

@onready var timer :Timer = $Timer
@onready var navigation_agent :NavigationAgent2D = $NavigationAgent2D

@export var player: Player = null

@export var speed :float= 30.0


func _ready():
	timer.timeout.connect(_on_timeout)
	makepath()

func _physics_process(_delta: float) -> void:
	if player:
		var dir: Vector2 = to_local(navigation_agent.get_next_path_position()).normalized()
		velocity = dir*speed
		print(self, " going to ", dir, " with vel ", velocity)
		print(navigation_agent.get_current_navigation_path())
	move_and_slide()

	
func makepath():
	if player:
		navigation_agent.target_position = player.global_position
		print("target: ", navigation_agent.target_position)

func _on_timeout():
	makepath()
	
	
func set_player(a_player: Player):
	player = a_player
	
	
