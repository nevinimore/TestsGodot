extends Node

@onready var player:Player = $Player
@onready var player_camera:PlayerCamera = $PlayerCamera


func _ready():
	
	player_camera.set_player(player)


