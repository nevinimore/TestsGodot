extends Node2D

@onready var character_body: CharacterBody2D = $Character

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	character_body.rotate(0.01)
